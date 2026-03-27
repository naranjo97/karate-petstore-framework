package com.petstore.runner;

import com.intuit.karate.junit5.Karate;

class SmokeRunner {

    @Karate.Test
    Karate testSmoke() {
        return Karate.run("classpath:com/petstore/features")
                .tags("@smoke");
    }
}