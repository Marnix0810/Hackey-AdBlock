# About HackeyBlock
## Update 2019-09-05:

I made a hard decision, but I am sadly announcing the following:

**[The Hackey PYE Project](https://github.com/Marnix0810/Hackey-Blocker) will not start, instead the [original Windows version](https://github.com/Marnix0810/HackeyBlock-Windows) will just stop support, fading out. The plans are to fully stop supporting HackeyBlock around end 2020. This may happen earlier or later. I am sorry to say this, but the HackeyBlock project seems to be too hard to maintain. After the EOS <small>(end of support)</small> of HackeyBlock, other projects like [FNew](https://marnix0810.github.io/FNew/), [Neveroffline](https://github.com/Marnix0810/Neveroffline) and [MuZikDL](https://github.com/Marnix0810/muZikDL) will have more time to be developed further. The HARR project will continue, but will only be updated to fix error reports.**

See [my post on The Marnix 0810 Site](https://marnix0810.wordpress.com/2019/09/06/end-of-support-for-hackeyblock/) for more information.

------



## What is Marnix 0810 HackeyBlock?

HackeyBlock (the full name is Marnix 0810 Hackey AdBlock) is an adblocker which uses the hosts-file to block online advertisings, trackers(, if set in preferences adult content) and certain malicious sites, this works almost on every site, but maybe if it doesn't the site you visit is a little shady? Well, anyways I hope you enjoy a faster web without online advertizing or malicious content!

## How does blocking via hosts-file work?
Well, nowadays every site is offered by a domain name, stored on a DNS-server. Hackey provides new DNS information, stored in a file that was widely used long before the existence of DNS servers: The hosts file. Because this file is located at the base of the operating system, it overwrites the data from DNS servers. But Hackey's records link ad-hosting domains to dead ends: the ads can no longer be loaded.

## Some examples:
**An example web page without Hackey on:**
![](https://marnix0810.github.io/Hackey-Blocker/IMG/example1.png)
[Go to image](https://marnix0810.github.io/Hackey-Blocker/IMG/example1.png)

***

**An example web page with Hackey on:**
![](https://marnix0810.github.io/Hackey-Blocker/IMG/example2.png)
[Go to image](https://marnix0810.github.io/Hackey-Blocker/IMG/example2.png)

## What is the HARR-utility?
(The HARR utility was designed for Hackey. You can find it's github repository [here](https://github.com/Marnix0810/HARR/))
HARR is an admin requester that Hackey depends on. Hackey needs admin rights because the hosts-file is inside the core of the OS (C:\Windows\System32\drivers\etc\hosts) and highly-protected.
