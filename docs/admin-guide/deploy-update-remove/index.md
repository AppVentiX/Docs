# Deploy, Update and Remove Applications with AppVentiX

With AppVentiX it is easy to deploy and update applications in real-time. It is possible to run multiple versions of an application side by side or replace an application with a new version immediately.

There are a couple of approaches, and they are largely the same for App-V and MSIX. Try out the different approaches to get familiar with them; you will see results in real-time. Managing applications with AppVentiX puts you back in control and will make you confident about application deployment and updates.

---

## Deploy a New Application

- Place the new package containing the application on the content store
- Create a publishing task for the application
- When a user logs on, or when the user clicks on the Refresh shortcut in the Start menu, the new application is published automatically. The user will receive the new application without having to log off and on again.

---

## Update an Existing Application

### Approach 1: Run old and new side by side

- You can either choose to create a new package or update the existing package. Save the package as a new package after updating (to allow old and new version to run side by side).
- Place the package containing the updated application on the content store
- Create a publishing task for the updated application (you can first assign this updated application to a test group)
- When a user logs on, they will receive the new updated application. Also when you run the refresh cycle (invoked centrally or on the machine itself), they will receive the updated application without having to log off and on again.
- After your test users have verified the updated application, edit the new publishing task and assign the production group
- Remove the old publishing task. After doing this, the old version will be removed for the user automatically.

### Approach 2: Run new version on test machine group

- Copy the updated application to a content store configured for your test machine group
- Create a publishing task and filter it to only apply for the test machine group
- Let users log in to the test machine group so they can test the application
- Copy the package to the production content store after tests are finished
- Edit the publishing task so it will also apply on the production machine group

### Approach 3: Replace old version with new version

- Save the package as a new package after updating, or save the package with the same package name/ID to increment the version number
- Place the package containing the updated application on the content store
- Create a new publishing task for the updated application and assign the same group as the old publishing task from the previous version
- Already logged-in users will receive the updated application when the refresh cycle runs. New users receive it when logging on. Already active users can continue to work in the old version. The new version will be active automatically when the user closes and re-opens the application.
- If you want to immediately replace the old version with the new one (force), remove the old publishing task (or configure the force upgrade option in the new publishing task). The old version will be closed and the new version becomes active immediately.

> **Note:** When forcing an immediate upgrade, the application will be forcibly closed. If the user should keep the old version open, leave the old publishing task in place and remove it later.

---

## Remove an Application

### Approach 1: Remove application for certain users

- Remove users from the AD group assigned to the publishing task
- The application will be automatically removed for the users that are removed from the AD group

### Approach 2: Remove application for all users (soft remove)

- Remove the publishing task for the package
- The application will be removed for the users
- After a while, remove the package from the content store. It will be removed from the cache on the machines by the balance cache mechanism of AppVentiX.

### Approach 3: Remove application for all users (hard remove)

- Remove the publishing task for the package
- The application will no longer be published for users
- Remove the package from the content store and invoke the refresh cycle. This will prevent the package from being pre-cached and it will be removed from the cache on the machines by the balance cache mechanism of AppVentiX.

### Approach 4: Remove application using the drain mechanism

- Remove the publishing task for the package
- The application will no longer be published for users
- Open the package options for the package you want to remove and select **Drain this package**. The package will no longer be deployed and will be removed from the cache when the refresh cycle runs. You can leave the package on the content store.

### Approach 5: Remove using inventory

- Inventory the machine(s)
- Filter the package you want to remove by name
- Select the package (on one or multiple machines)
- Click **Remove Package**. The package will now be removed immediately.
