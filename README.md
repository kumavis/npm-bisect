quick and dirty npm package version testing tool

it doesnt actually bisect, it checks all versions in order (eheh)

### usage

prolly dont run this in your project directory, it will install packages and stuff

```bash
./bisect.sh ses 'import("ses").then(async ()=>{lockdown({ domainTaming: "unsafe", dateTaming: "unsafe" });}).catch(() => process.exit(2)).then(()=>{c=new Compartment;c.evaluate("Date.now()");}).catch(() => process.exit(3))'
```

summary:
```
-----------------------------------
Test Summary for ses
-----------------------------------
0.0.0: bad (2)
0.0.1: bad (2)
0.1.2: bad (2)
0.1.3: bad (2)
0.2.0: bad (2)
0.3.0: bad (2)
0.4.0: bad (2)
0.5.0: bad (2)
0.5.1: bad (2)
0.5.2: bad (2)
0.5.3: bad (2)
0.6.0: bad (2)
0.6.1: bad (2)
0.6.2: bad (2)
0.6.3: bad (2)
0.6.4: bad (2)
0.6.5: bad (2)
0.7.0: bad (2)
0.7.1: bad (2)
0.7.2: bad (2)
0.7.3: bad (2)
0.7.4: bad (2)
0.7.5: bad (2)
0.7.6: bad (2)
0.7.7: bad (2)
0.8.0: bad (2)
0.9.0: bad (2)
0.9.1: bad (2)
0.10.0: bad (2)
0.10.1: bad (2)
0.10.2: bad (2)
0.10.3: bad (2)
0.10.4: bad (2)
0.11.0: bad (2)
0.11.1: bad (2)
0.12.0: bad (2)
0.12.1: bad (2)
0.12.2: bad (2)
0.12.3: bad (2)
0.12.4: bad (2)
0.12.5: bad (2)
0.12.6: bad (2)
0.12.7: bad (2)
0.13.0: bad (2)
0.13.1: bad (2)
0.13.2: bad (2)
0.13.3: bad (2)
0.13.4: bad (2)
0.13.5: bad (2)
0.14.0: bad (2)
0.14.1: bad (2)
0.14.2: bad (2)
0.14.3: good
0.14.4: good
0.14.5: good
0.15.0: good
0.15.1: good
0.15.2: good
0.15.3: good
0.15.4: good
0.15.5: good
0.15.6: good
0.15.7: good
0.15.8: good
0.15.9: good
0.15.10: good
0.15.11: good
0.15.12: good
0.15.13: good
0.15.14: good
0.15.15: good
0.15.16: good
0.15.17: good
0.15.18: good
0.15.19: good
0.15.20: good
0.15.21: good
0.15.22: good
0.15.23: good
0.15.24: good
0.16.0: good
0.16.1: good
0.17.0: good
0.17.1: good
0.18.0: good
0.18.1: good
0.18.2: good
0.18.3: good
0.18.4: good
0.18.5: good
0.18.7: good
0.18.8: bad (3)
1.0.0: bad (3)
1.0.1: bad (3)
1.1.0: bad (3)
1.2.0: bad (3)
1.3.0: bad (3)
1.4.0: bad (3)
1.4.1: bad (3)
1.5.0: bad (3)
1.6.0: bad (3)
1.7.0: bad (3)
1.8.0: bad (3)
1.9.0: bad (3)
-----------------------------------
```