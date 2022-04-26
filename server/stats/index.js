const prometheus = require('prom-client');
const register = prometheus.register;

const prometheusTimeout = GetConvarInt('prometheus_timeout', 5000);
const authEnabled = GetConvarInt('prometheus_auth_enabled', 0);
const authLogin = GetConvar('prometheus_login', 'admin');
const authPassword = GetConvar('prometheus_password', 'admin');
const authorizationHeader = 'Basic ' + new Buffer(authLogin + ':' + authPassword).toString('base64');

const playerCount = new prometheus.Gauge({ name: 'fxs_player_count', help: 'Number of connected players.' });
const playerConnections = new prometheus.Counter({ name: 'fxs_player_connections', help: 'Number of player connections.' });
const playerDisconnections = new prometheus.Counter({ name: 'fxs_player_disconnections', help: 'Number of player disconnections.' });
const averageLatency = new prometheus.Gauge({ name: 'fxs_average_player_latency', help: 'Average player latency.' });
const latencyHistogram = new prometheus.Histogram({ name: 'fxs_players_latency', help: 'Players latency.', buckets: [10, 20, 50, 70, 100, 120, 150, 160, 200] });
const minPlayerPing = new prometheus.Gauge({ name: 'fxs_min_player_ping', help: 'Minimum player ping.' });
const maxPlayerPing = new prometheus.Gauge({ name: 'fxs_max_player_ping', help: 'Maximum player ping.' });

setInterval(() => {
    const numIndices = GetNumPlayerIndices();

    let cumulativeLatency = 0;
    let minPing, maxPing;

    for (let playerIndex = 0; playerIndex < numIndices; playerIndex++) {
        const player = GetPlayerFromIndex(playerIndex);
        const playerPing = GetPlayerPing(player);
        cumulativeLatency += playerPing;
        if (!minPing || minPing > playerPing) {
            minPing = playerPing;
        }
        if (!maxPing || maxPing < playerPing) {
            maxPing = playerPing;
        }
        latencyHistogram.observe(playerPing);
    }

    playerCount.set(numIndices);
    if (numIndices > 0) {
        averageLatency.set(cumulativeLatency / numIndices);
        minPlayerPing.set(minPing);
        maxPlayerPing.set(maxPing);
    } else {
        averageLatency.set(0);
        minPlayerPing.set(0);
        maxPlayerPing.set(0);
    }
}, prometheusTimeout);

on('playerConnecting', (playerName, setKickReason, tempPlayer) => {
    playerConnections.inc();
});

on('playerDropped', (player, disconnectReason) => {
    playerDisconnections.inc();
});

on('prometheus:addMetric', (type, name, description, cb) => {
    if (!prometheus[type]) {
        console.error(`[FiveM Prometheus] Invalid metric type ${type} for ${name}`);
        return;
    }
    let metric = new prometheus[type]({ name: name, help: description });

    setInterval(() => {
        cb((methodName, value) => {
            if (metric[methodName]) {
                metric[methodName](value);
            }
        });
    }, prometheusTimeout);
});

on('prometheus:_getMetrics', (cb) => {
    cb(register.metrics());
});