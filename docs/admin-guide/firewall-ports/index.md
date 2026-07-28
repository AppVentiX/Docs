# Firewall and Communication Ports Used by AppVentiX

By default, AppVentiX does not use any other ports other than file share (SMB) access (port 445), or port 443 for QUIC-enabled shares.

See the [QUIC Share](../quic-share/index.md) section for more information about setting up a QUIC share.

## Port Exceptions

| Protocol/Port | Usage |
|--------------|-------|
| Port 445 (SMB) | File share access (default) |
| Port 443 (QUIC/HTTPS) | QUIC-enabled share access |
| Port 389 (LDAP) | AD domain connections to retrieve user groups |
| Port 636 (LDAPS) | AD domain connections when LDAPS is enabled |
| Port 443 (HTTPS) | Entra ID connections and Azure Virtual Desktop (AVD) connections via Graph API |
| Store URLs (HTTPS) | When importing packages from the Microsoft Store, the Store URL needs to be accessible |

In Active Directory domain environments, the AD connection is most of the time already possible because a lot of authentication traffic is directed to domain controllers. AppVentiX will make use of this default AD integration already known in the operating system.
