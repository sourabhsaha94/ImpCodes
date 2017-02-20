#Agent nut file

function logLightLevel(lightlevel){
    server.log(lightlevel);
}
device.on("light",logLightLevel);

#Device nut file

light_level <- hardware.lightlevel();
agent.send("light",light_level);
