# About HackeyBlock
## What is Marnix 0810 HackeyBlock?

HackeyBlock (the full name is Marnix 0810 Hackey AdBlock) is an adblocker which uses the hosts-file to block online advertisings, trackers(, if set in preferences adult content) and certain malicious sites, this works almost on every site, but maybe if it doesn't the site you visit is a little shady? Well, anyways I hope you enjoy a faster web without online advertizing or malicious content!

## How does blocking via hosts-file work?
Well, nowadays every site is offered by a domain name, stored on a DNS-server. Hackey provides new DNS information, stored in a file that was widely used long before the existence of DNS servers: The hosts file. Because this file is located at the base of the operating system, it overwrites the data from DNS servers. But Hackey's records link ad-hosting domains to dead ends: the ads can no longer be loaded.

## Some examples:
**An example web page without Hackey on:**
![](https://marnix0810.files.wordpress.com/2019/06/hackey-adblock-example1.png)
[Go to image](https://marnix0810.files.wordpress.com/2019/06/hackey-adblock-example1.png)

***

**An example web page with Hackey on:**
![](https://marnix0810.files.wordpress.com/2019/06/hackey-adblock-example2.png)
[Go to image](https://marnix0810.files.wordpress.com/2019/06/hackey-adblock-example2.png)

## What is the HARR-utility?
(The HARR utility was designed for Hackey. You can find it's github repository [here](https://github.com/Marnix0810/HARR/))
HARR is an admin requester that Hackey depends on. Hackey needs admin rights because the hosts-file is inside the core of the OS (C:\Windows\System32\drivers\etc\hosts) and highly-protected.
