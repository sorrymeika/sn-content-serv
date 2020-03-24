const { registerConsumer } = require('sonorpc');

const baseRPC = registerConsumer({
    providerName: 'base',
    registry: {
        port: 3006
    }
});

const sellerRPC = registerConsumer({
    providerName: 'seller',
    registry: {
        port: 3006
    }
});

const userRPC = registerConsumer({
    providerName: 'user',
    registry: {
        port: 3006
    }
});

module.exports = {
    baseRPC,
    sellerRPC,
    userRPC,
};
