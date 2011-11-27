#### HEXParser

This is a helper method for determining if a string is a valid HEX color string.  If it isn't it will convert it.

- `gfe7t` Becomes `#FFEE77`
- `#000000000` > `#000000`
- `0ffggk` > `#00FFFF`
- `#` > `#000000`
- `""` > `#000000`
- `fjfkdslafjdk` > `#FFDAFD`
- `fkdl` > `#FD0000`

***

###### Behavior

Some unusual/odd behaviors.

- If the string is to long, it will be truncated.

- If the string is to short it will have `0`s added to the end.

- If the string contains 3 values they will be doubled.

- If a character isn't a valid hex value 1-9 A-F it will be dropped, and all the other characters will slide in and take it's palace.

Feel free to ask me questions on [Twitter / @SkylarSch](http://twitter.com/#!/skylarsch)