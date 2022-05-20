# GFM playground for extended Markdown syntax

## Tables

| a   | b   |
| --- | --- |
| 0   | c   |
| 1   | d   |

### Alignment

|    a |   b   | c    | d     |
| ---: | :---: | :--- | ----- |
|   00 |  11   | 2    | 33333 |
|    4 | 5555  | 666  | 77    |

## Footnotes

Example footnote.[^1] Long footnote.[^2]

[^1]: Here's a footnote.
[^2]: Here is a longer footnote containing:

	- A list.

	```
	code block
  	```

	And a paragraph!

## Heading IDs

### Heading A {#the-a}

This is A. [Link to heading B](#the-b).

### Heading B {#the-b}

This is B. [Link to heading A](#the-a).

## Definitions

Term
: Definition

Term2
: Definition 1
: Definition 2

## Strike-through

This sentence is ~~deleted~~ modified.

## Task list

- [x] Allocate free time.
- [ ] Buy bananæ.
- [ ] Buy potatœ.

## Emoji

🗿:tm:

## Highlight

This is ==Highlighted==.

## Subscript

H~2~O. H_2_O. $\text{H}_2\text{O}$.

## Superscript

x^2^yz x^2^yz.

x^2yz x^2yz. $x^2yz$

## Autolink

https://example.com
