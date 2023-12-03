package com.net128.app.jmespath;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.burt.jmespath.Expression;
import io.burt.jmespath.jackson.JacksonRuntime;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.stream.Collectors;

public class JmespathCli {

    public static void main(String[] args) {
        if (args.length < 1 || args.length > 2) {
            System.out.println("Usage: java YourJmespathApplication <jmespath-query> [json-string]");
            System.out.println("       If [json-string] is not provided, input is read from standard input.");
            System.exit(1);
            return;
        }

        String query = args[0];
        String json;

        try {
            if (args.length == 2) {
                json = args[1];
            } else {
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
                    json = reader.lines().collect(Collectors.joining(System.lineSeparator()));
                }
            }

            ObjectMapper mapper = new ObjectMapper();
            JacksonRuntime runtime = new JacksonRuntime();
            JsonNode jsonNode = mapper.readTree(json);
            Expression<JsonNode> expression = runtime.compile(query);
            JsonNode result = expression.search(jsonNode);
            System.out.println(result.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
