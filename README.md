# pr-bisect

Bisection of PRs / merge commits using `git bisect`. If a PR merge was identified, the logic looks inside to identify the exact commit which broke.

### Usage

```bash
docker run -t --rm -v $(pwd):/src -v /tmp:/tmp ghcr.io/mihaigalos/docker/pr-bisect:0.0.1 BAD_COMMIT GOOD_COMMIT RUNNER
```

`RUNNER` is the logic delegated to git bisect: i.e. from your tester returning 0 for success and != 0 for failure.

### Example usage

Have a look [here](https://github.com/mihaigalos/pr-bisect/blob/f2c7397f9cac518fe216f264deb49cbfee70e5a0/Justfile#L15-L26).
