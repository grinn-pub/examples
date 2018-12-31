
# LoRa Gateway

LoRa Gateway based on GRINN [litesom](https://grinn-global.com/products/litesom/) and iC880A module (with Semtech SX1301). 

## Prepare the board

 - put flashed microSD card into the socket on the board,
 - connect an Ethernet cable and/or put your SIM card into the socket under the LoRa iC880A module,
 - connect 868MHz antenna to the u.fl connector on the LoRa module (see [datasheet page 7](https://wireless-solutions.de/downloads/Radio-Modules/iC880A/iC880A_Datasheet_V1_0.pdf)),
 - connect GSM antenna to `ANT` (`J7`) connector (*if you want to use GSM module, optional*),
 - connect GPS antenna to `GPS ANT` (`J13`) connector under the LoRa module (*if you want to get GPS position of your device, optional*),
 - connect 12V power supply to the `J14` connector.


## Connect to the board

There are two ways to get access to your gateway:

 1. Via SSH (if you know the IP address of the gateway)
 2. Via USB<->UART converter connected to the `DBG` (`J4`) goldpins (baudrate: 115200, 8N1)

Log in as:

    user: root
    password: root

**It's highly recommended to change the password after first log in.**


## Configure the Gateway

To configure your device it's necessary to edit few files with embedded `vi` editor. (More about using `vi` [here](https://staff.washington.edu/rells/R110/)).

### Gateway EUI

1. You own your EUI

If you own your EUI write it into `/ttn/local_conf.json` as `gateway_ID`. Type the following command:

    vi /ttn/local_conf.json

and overwrite the `gateway_ID` value:

    ...
    "gateway_conf": {
        "gateway_ID": "<my EUI>",
        /* Devices */
    ...

Save the file and then run the following command:

    sync

2. You don't own your EUI

If you don't own your EUI you can generate EUI for your gateway via the following command:

    /ttn/update_gwid.sh /ttn/local_conf.json

The script should response that way:

    Gateway_ID set to <EUI> in file local_conf.json

Then run the following command:

    sync

3. You want to check current EUI

To see currently set Gateway EUI run the following command:

    grep "gateway_ID" /ttn/local_conf.json

**To apply changes of gateway settings it's necessary to reset the device by turning off and on power supply or typing the following command:** 

    reboot

### GSM - configure APN & PIN

*This paragraph consists information how to set up the Internet connection over the GSM module. If you want to use only Ethernet link you don't need to follow this part.*

1. APN

Open the `apn` file with the `vi` editor (type the following command):

    vi /etc/ppp/chatscripts/apn

edit the last string (default value is `internet`) according to the following:

    AT+CGDCONT=1,"IP","<APN>"

Save the file and then type:

    sync

2. PIN

*If your SIM card doesn't have a PIN then you don't need to do this step. Otherwise follow the instructions.*

Open the `pin` file with the `vi` editor (type the following command):

    vi /etc/ppp/chatscripts/pin

change the default string:

    AT

to the following:

    AT+CPIN=<PIN>

where `<PIN>` is your pin e.g. `1234`.
Then type command:

    sync

**To apply changes of gateway settings it's necessary to reset the device by turning off and on power supply or typing the following command:** 

    reboot
