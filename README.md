# Parsing code challenge

*Example Input:*

```
[
 {date: 2014-01-01, a: 5, b:1},
 {date: 2014-01-01, xyz: 11},
 {date: 2014-10-10, qbz: 5},
 {date: 2014-10-10, v: 4, q: 1, strpm: -99}
]
```

*Expected output:*

```
[
 {date: 2014-01-01, a: 5, xyz: 11, b: 1 },
 {date: 2014-10-10, qbz: 5, v: 4, q: 1, strpm: -99},
]
```

## How to run

```
 ruby -I lib/ example.rb
```

## How to test

```
bundle
rspec spec --format doc

```
