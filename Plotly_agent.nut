#require "Plotly.class.nut:1.0.0"

function postToPlotly(reading) {
    local timestamp = plot1.getPlotlyTimestamp();
    plot1.post([
        {
            "name" : "Temperature",
            "x" : [timestamp],
            "y" : [reading["temp"]]
        }
    ]);
}

plot1 <- Plotly("sourabhsaha94", "eyfMPSVbf2GJggpEn41P", "TestImpData", true, ["Temperature"], function(error, response, decoded) {
    device.on("reading", postToPlotly);
    server.log("See plot at " + plot1.getUrl());
});
