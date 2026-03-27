package com.petstore.runner;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

class TestRunner {

    @Test
    void testAll() {
        Karate.run("classpath:com/petstore/features")
                .tags("~@wip")
                .parallel(1);
    }

    @Test
    void testPets() {
        Karate.run("classpath:com/petstore/features/pets")
                .tags("@regression")
                .parallel(1);
    }

    @Test
    void testStore() {
        Karate.run("classpath:com/petstore/features/store")
                .tags("@regression")
                .parallel(1);
    }
}