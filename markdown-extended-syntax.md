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

## Diagrams

### Mermaid

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

### GeoJSON

```geojson
{
  "type": "Polygon",
  "coordinates": [
      [
          [-90,30],
          [-90,35],
          [-90,35],
          [-85,35],
          [-85,30]
      ]
  ]
}
```

### TopoJSON

```topojson
{
  "type": "Topology",
  "transform": {
    "scale": [0.0005000500050005, 0.00010001000100010001],
    "translate": [100, 0]
  },
  "objects": {
    "example": {
      "type": "GeometryCollection",
      "geometries": [
        {
          "type": "Point",
          "properties": {"prop0": "value0"},
          "coordinates": [4000, 5000]
        },
        {
          "type": "LineString",
          "properties": {"prop0": "value0", "prop1": 0},
          "arcs": [0]
        },
        {
          "type": "Polygon",
          "properties": {"prop0": "value0",
            "prop1": {"this": "that"}
          },
          "arcs": [[1]]
        }
      ]
    }
  },
  "arcs": [[[4000, 0], [1999, 9999], [2000, -9999], [2000, 9999]],[[0, 0], [0, 9999], [2000, 0], [0, -9999], [-2000, 0]]]
}
```

### STL

```stl
solid cube_corner
  facet normal 0.0 -1.0 0.0
    outer loop
      vertex 0.0 0.0 0.0
      vertex 1.0 0.0 0.0
      vertex 0.0 0.0 1.0
    endloop
  endfacet
  facet normal 0.0 0.0 -1.0
    outer loop
      vertex 0.0 0.0 0.0
      vertex 0.0 1.0 0.0
      vertex 1.0 0.0 0.0
    endloop
  endfacet
  facet normal -1.0 0.0 0.0
    outer loop
      vertex 0.0 0.0 0.0
      vertex 0.0 0.0 1.0
      vertex 0.0 1.0 0.0
    endloop
  endfacet
  facet normal 0.577 0.577 0.577
    outer loop
      vertex 1.0 0.0 0.0
      vertex 0.0 1.0 0.0
      vertex 0.0 0.0 1.0
    endloop
  endfacet
endsolid
```

## Collapsed sections

<details><summary>Build results</summary>
<p>

#### Build failed

No really, it did!

</p>
</details>
