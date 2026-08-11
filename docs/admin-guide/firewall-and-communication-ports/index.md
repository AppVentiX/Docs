# Firewall and Communication Ports

By default, AppVentiX does not use any other ports other than file share (SMB) access (port 445), or port 443 for QUIC-enabled shares. See the [QUIC Share](../quic-share/index.md) section for more information about setting up a QUIC share.

There are a few exceptions:

- For AD domain connections (to retrieve user groups): port 389 (LDAP) or 636 (LDAPS)
- For Entra ID connections and Azure Virtual Desktop (AVD) connections: the default Graph API ports (443) are used to reach online Microsoft services
- When importing packages from the Microsoft Store, the Store URL needs to be accessible

In Active Directory domain environments, the AD connection is most of the time already possible because a lot of authentication traffic is directed to domain controllers. AppVentiX will make use of this default AD integration already known in the operating system.
