use jmespath;
use std::env;
use std::io::{self, Read};

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        eprintln!("Usage: jmespath-rust-cli '<jmespath-query>' [n invocations] ['json-string']");
        std::process::exit(1);
    }

    let query = &args[1];
    let mut json_input = String::new();
    let n = if args.len() > 2 { args[2].parse::<usize>().unwrap_or(0) } else { 0 };

    if args.len() > 3 {
        json_input = args[3].clone();
    } else {
        io::stdin().read_to_string(&mut json_input).unwrap();
    }

    let expr = jmespath::compile(query).unwrap();
    let data = jmespath::Variable::from_json(&json_input).unwrap();

    if n > 0 {
        eprintln!("Input JSON: {}", &json_input[..std::cmp::min(json_input.len(), 1024)]);
        eprintln!("Query: {}", query);
        eprintln!("n: {}", n);
    }

    let start_time = std::time::Instant::now();
    for _ in 0..n {
        expr.search(data.clone()).unwrap();
    }
    let elapsed = start_time.elapsed();

    let result = expr.search(data).unwrap();
    let result_str = serde_json::to_string(&result).unwrap();
    println!("Result: {}", result_str);

    if n > 0 {
        println!("{:.4}", elapsed.as_secs_f64());
    }
}
