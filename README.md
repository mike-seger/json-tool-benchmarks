

```
sudo apt install jp
or
brew install jmespath/jmespath/jp
```

```
./tools/jmespath/run.sh 2>/dev/null | tee /tmp/1 && cat /tmp/1 | tools/format.sh
```
