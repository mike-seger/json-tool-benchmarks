# Example 
```
cat ../../../data/people.json| cargo run -- "people[?lastName=='Jones']|[-1:].{f: firstName, l: lastName}" 1
```

# Build
```
cargo build --release
```
