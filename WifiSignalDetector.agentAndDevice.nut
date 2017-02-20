//Device code

#require "WS2812.class.nut:3.0.0"

spi <- null;
led <-null;
wifi <- [];
rssi <- 0;

function displayColor(){
    wifi = imp.scanwifinetworks();
    rssi = wifi[0]["rssi"];
    local color = {};
    local red = 255;
    local green = 255;
    local blue = 255;
    if(rssi<(-80)){
        red=255;
        green=0;
        blue=0;
    }else if(rssi<(-60)){
        red=255;
        green=255;
        blue=0;
    }else if(rssi<(-50)){
        red=255;
        green=0;
        blue=255;
    }else if(rssi<(-40)){
        red=0;
        green=255;
        blue=255;
    }else{
        red=0;
        green=255;
        blue=0;
    }
    color = [red,green,blue];
    led.set(0,color).draw();
    agent.send("light",rssi);
    imp.wakeup(3.0,displayColor);
}

spi = hardware.spi257;
spi.configure(MSB_FIRST,7500);
hardware.pin1.configure(DIGITAL_OUT,1);

led = WS2812(spi,1);

displayColor();

//Agent code

function logLightLevel(rssi){
    server.log(rssi);
    
}
device.on("light",logLightLevel);
