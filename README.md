# Installation
```
npm install periodic-read
```

# Usage

### Read file every 500ms and print result to the console
```JavaScript
PeriodicRead = require('periodic-read').PeriodicRead

pr = new PeriodicRead('/var/log/syslog')

pr.on('line', function(linetext) {
    console.log(linetext);
});

pr.on('error', function(err) {
    console.log("FAIL:", err)
});
```

### Options
#### Different separator
If your special case requires line to be separated by something different than `\n`, you can specify new line separator as second line argument. For example if every line begins with '2014' and you want to use it as separator:

```JavaScript
pr = new PeriodicRead('/tmp/something.txt', '2014')
``` 

#### Read interval
By default, `PeriodicRead` will read file every 500ms, but this can be changed by providing number of miliseconds to wait as `interval` argument. Example:

```JavaScript
pr = new PeriodicRead('/var/log/security.log', '\n', 2000)
```



# Credits
This project is heavily insipred by [node-tail](https://github.com/lucagrulla/node-tail) created by Luca Grula. The main difference is that file is not being observed through linux kernel, but it's forcibly read every 500 ms by default.

# License
This project is licensed with MIT license.