this is a script that can calculate avaliable `ip address range` `netmask`/`netmask length` 

based on `ip add` and `netmask length`/`netmask`

**Usage**
`network.sh`
Input : IP-address netmask
or	IP-address netmask-length

**Examples**
`network.sh`
`192.168.1.1 24`
or `192.168.1.2 255.255.255.0`

it'll give you the following informations about the network:

* network-id：           192.168.1.0
* netmask-length：      24
* netmask：              255.255.255.0
* wildcard-mask：        0.0.0.255
* ip address range：     192.168.1.1 - 192.168.1.254

