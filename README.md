# Compare JSON tool performance

Currently several JMES implementation are compared.

## Install JP

```
sudo apt install jp
or
brew install jmespath/jmespath/jp
```

## Run Benchmarks

```
./tools/jmespath/run.sh 2>/dev/null | tee /tmp/1 && cat /tmp/1 | tools/format.sh ; rm /tmp/1
./tools/jmespath/run-compliance.sh 2>/dev/null | tee /tmp/1 && cat /tmp/1 | tools/format.sh ; rm /tmp/1
```

## Benchmark Results

### Compliance Tests
 | Benchmark |            n |   jp-java |   jp-graal |   jp-go |   jp-rust |   jp-js |                    
 |--------------|----------:|----------:|-----------:|--------:|----------:|--------:|
 | boolean |        1000000 |        87 |          27 * |        66 |     546 |   766 |              
 | current |          10000 |        41 |          37 * |       117 |    1836 |   1402 |             
 | filters |          10000 |       105 |         37 |       31 * |     132 |   218 |              
 | functions |       100000 |       580 |        131 |      109 * |    1337 |   1415 |             
 | identifiers |      10000 |       260 |          68 * |       245 |    1300 |   3669 |             
 | indices |         100000 |       531 |        193 |      173 * |    1326 |   1234 |             
 | literal |         100000 |        30 |           2 * |        62 |     934 |   1328 |             
 | multiselect |     100000 |       397 |         237 * |       292 |    1006 |   1219 |             
 | slice |           100000 |       795 |         453 * |      1294 |    3070 |   3267 |             
 | syntax |          100000 |       177 |          60 * |       137 |     431 |   1315 |             
 | wildcard |        100000 |      1468 |         975 * |      1192 |    5582 |   5323 |  

### Large Input
 | Benchmark |        n |   jp-java |   jp-graal |   jp-go |   jp-rust |   jp-js |         
 |-----------|---------:|----------:|-----------:|--------:|----------:|--------:|
 | select_attr |    100 |       860 |        552 |      423 * |    9515 |   579 |   
 | sort_by |         10 |       104 |         59 |       45 * |     940 |   83 |    
 | sort |            10 |       392 |        370 |     256 |      1075 |      189 * |     
 | min |             10 |       258 |        142 |       55 * |     915 |   69 |    
 | min_by |          10 |       166 |         69 |       18 * |     916 |   32 |    
 | max |             10 |       258 |        143 |       58 * |     913 |   70 |    
 | max_by |          10 |       172 |         70 |       18 * |     904 |   31 |    
 | contains |        10 |       178 |        149 |      122 * |     981 |   150 |   
 | sum |             10 |       245 |        126 |       58 * |     904 |   71 |    
 | avg |             10 |       253 |        124 |       53 * |     922 |   71 |    
 | reverse |         10 |        36 |         15 |        2 * |     801 |   2 * | 

## Links

- https://jmespath.org/
- https://jmespath.org/libraries.html
- https://github.com/jmespath/jmespath.test
- [Compliance Test Results](compliance-test-results.tsv)
- [Large Input Test Results](large-input-test-results.tsv)
