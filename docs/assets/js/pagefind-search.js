(() => {
  "use strict";

  const FILTER_NAME = "section";
  const DEBOUNCE_MS = 150;
  const IDLE_MESSAGE = "Type to search the docs";

  let pagefind = null;
  let pagefindReady = null;

  function loadPagefind() {
    if (!pagefindReady) {
      pagefindReady = import("/pagefind/pagefind.js")
        .then((mod) => {
          pagefind = mod;
          return pagefind.init();
        })
        .catch((err) => {
          console.error("Pagefind failed to load", err);
        });
    }
    return pagefindReady;
  }

  function checkedSections(root) {
    return Array.from(
      root.querySelectorAll("[data-pf-filter-checkbox]:checked")
    ).map((el) => el.value);
  }

  function debounce(fn, ms) {
    let handle;
    return (...args) => {
      clearTimeout(handle);
      handle = setTimeout(() => fn(...args), ms);
    };
  }

  function renderMeta(metaEl, count) {
    if (count === 0) {
      metaEl.textContent = "No matching documents";
    } else {
      metaEl.textContent = `${count} matching document${count === 1 ? "" : "s"}`;
    }
  }

  function renderResults(listEl, results) {
    listEl.innerHTML = "";
    for (const result of results) {
      const li = document.createElement("li");
      li.className = "md-search-result__item";

      const article = document.createElement("article");
      article.className = "md-search-result__article md-search-result__article--document";

      const link = document.createElement("a");
      link.href = result.url;
      link.className = "md-search-result__link";

      const h1 = document.createElement("h1");
      h1.className = "md-search-result__title";
      h1.textContent = result.meta && result.meta.title ? result.meta.title : result.url;

      const teaser = document.createElement("p");
      teaser.className = "md-search-result__teaser pf-search-result__excerpt";
      teaser.innerHTML = result.excerpt;

      article.appendChild(h1);
      article.appendChild(teaser);
      link.appendChild(article);
      li.appendChild(link);
      listEl.appendChild(li);
    }
  }

  async function runSearch(root, query) {
    const metaEl = root.querySelector("[data-pf-search-meta]");
    const listEl = root.querySelector("[data-pf-search-list]");

    if (!query) {
      listEl.innerHTML = "";
      metaEl.textContent = IDLE_MESSAGE;
      return;
    }

    await loadPagefind();
    if (!pagefind) return;

    const sections = checkedSections(root);
    // `{ [FILTER_NAME]: [a, b] }` is an AND across values for this filter key
    // (a page would need every value at once, which is impossible since each
    // page has exactly one section) - the OR-across-values form is `any`.
    const filters = sections.length
      ? { any: sections.map((value) => ({ [FILTER_NAME]: value })) }
      : {};

    const search = await pagefind.search(query, { filters });
    const results = await Promise.all(
      search.results.slice(0, 20).map((r) => r.data())
    );

    renderMeta(metaEl, results.length);
    renderResults(listEl, results);
  }

  function initSearchBox(root) {
    const input = root.querySelector("[data-pf-search-input]");
    const resetBtn = root.querySelector("[data-pf-search-reset]");
    const filterBoxes = root.querySelectorAll("[data-pf-filter-checkbox]");
    const toggle = document.getElementById("__search");

    const debounced = debounce(() => runSearch(root, input.value.trim()), DEBOUNCE_MS);

    // At desktop widths the search input is always visible inline in the
    // header (Material's own responsive layout), not just an icon that
    // opens it - clicking straight into that visible field is the natural
    // action, so it needs to expand the panel exactly like clicking the
    // icon does, or the filters/results stay hidden with no visible cause.
    input.addEventListener("focus", () => {
      if (toggle && !toggle.checked) {
        toggle.checked = true;
      }
    });

    input.addEventListener("input", debounced);
    filterBoxes.forEach((box) =>
      box.addEventListener("change", () => runSearch(root, input.value.trim()))
    );

    if (resetBtn) {
      resetBtn.addEventListener("click", () => {
        input.value = "";
        runSearch(root, "");
      });
    }

    // Warm up the Pagefind index as soon as the search box exists, so the
    // first keystroke doesn't pay the network/WASM load cost.
    loadPagefind();
  }

  document.addEventListener("DOMContentLoaded", () => {
    document
      .querySelectorAll("[data-pf-search-form]")
      .forEach((form) => initSearchBox(form.closest(".md-search")));
  });
})();
