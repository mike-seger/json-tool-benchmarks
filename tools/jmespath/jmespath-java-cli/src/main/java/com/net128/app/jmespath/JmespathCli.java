package com.net128.app.jmespath;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.burt.jmespath.jackson.JacksonRuntime;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.stream.Collectors;

public class JmespathCli {

    public static void main(String[] args) {
        try {
            if (args.length < 1) {
                System.err.println("Usage: java -jar YourJmespathApplication.jar '<jmespath-query>' [n invocations] ['json-string']");
                System.exit(1);
            }

            var query = args[0];
            var json = "";
            var n = 0;

            if (args.length == 2) n = Integer.parseInt(args[1]);
            if (args.length > 2) {
                n = Integer.parseInt(args[1]);
                json = args[2];
            } else {
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
                    json = reader.lines().collect(Collectors.joining(System.lineSeparator()));
                }
            }

            if(n>0) {
                System.err.println("Input JSON: " + json.substring(0, Math.min(json.length(), 1024)));
                System.err.println("Query: " + query);
                System.err.println("n: " + n);
            }

            var mapper = new ObjectMapper();
            var runtime = new JacksonRuntime();
            var jsonNode = mapper.readTree(json);
            var expression = runtime.compile(query);
            var time = System.currentTimeMillis();
            for(var i=0;i<n;i++) expression.search(jsonNode);
            time = System.currentTimeMillis() - time;

            var result = expression.search(jsonNode);

            if (result.isTextual()) System.out.println(result.asText());
            else System.out.println(result);

            if(n>0) System.out.printf("%.4f\n", time/1000.0);
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }
    }
}
