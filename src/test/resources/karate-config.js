function fn() {
    var env = karate.env; // lee la variable -Dkarate.env
    karate.log('Ambiente activo:', env);

    if (!env) {
        env = 'dev'; // ambiente por defecto
    }

    var config = {
        env: env,
        connectTimeout: 10000,
        readTimeout: 10000
    };

    if (env === 'dev') {
        config.baseUrl = 'https://petstore.swagger.io/v2';
        config.apiKey = 'special-key';
    } else if (env === 'staging') {
        config.baseUrl = 'https://petstore.swagger.io/v2'; // misma URL, en un proyecto real sería diferente
        config.apiKey = 'staging-key';
    }

    karate.configure('connectTimeout', config.connectTimeout);
    karate.configure('readTimeout', config.readTimeout);

    return config;
}