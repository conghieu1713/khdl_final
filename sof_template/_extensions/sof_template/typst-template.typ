
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#import "@preview/cetz:0.3.0"

// Color Declaration
#let ueh-orange = cmyk(0%, 70%, 90%, 0%)
#let ueh-blue = cmyk(100%, 90%, 35%, 30%)
#let ueh-green = cmyk(100%, 50%, 50%, 20%)

// Draw Beetween Line
#let between_line =cetz.canvas({
  import cetz.draw: *
  line(
    (0,0), (0,257mm),
    stroke: ueh-blue + 1pt,
  )
})

// Create Template
#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  subject: none,
  instructors: none,
  faculty: none,
  cols: 1,
  margin: (x: 1.00in, y: 1.00in),
  paper: "a4",
  lang: "vi",
  region: "VN",
  font: (),
  fontsize: 12pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  // Page Margin
  set page(margin: (
    left: 20mm,
    top: 20mm,
    right: 15mm,
    bottom: 20mm
  ))
  // Cover Page
  //
  // Logo
  place(
    top + left,
    image(
      "img/sof.png",
      width: 55mm,
    ),
  )
  // Footer
  place(
    bottom + right,
    image(
      "img/footer.png",
      width: 105mm,
    ),
  )
  // Between Line
  place(
    dx: 60mm,
    between_line,
  )
  // Falcuty
  place(
    bottom + left,
    [
      #pad(right: 120mm)[
        #par(leading: 0.5em)[
          #text(
            size: 22pt,
            fill: ueh-green,
            [Trường],
            weight: "bold"
          )
        ]
        #par(leading: 0.5em)[
          #text(
            size: 14pt,
            fill: ueh-green,
            [Kinh Doanh],
            weight: "bold"
          )
        ]
        #v(3mm)
        #par(leading: 0.5em)[
          #text(
            size: 14pt,
            fill: ueh-green,
            [Khoa Tài chính],
            weight: "bold"
          )
        ]
        #par(leading: 0.5em)[
          #text(
            size: 10pt,
            fill: black,
            [B1.902, 279 Nguyễn Tri Phương, Phường Diên Hồng, TP. Hồ Chí Minh]
          ) \
        ]
        #par(leading: 0.5em)[
          #text(
            size: 10pt,
            fill: black,
            style: "italic",
            [Tel: +84-28 3526 5830]
          ) \
          #text(
            size: 10pt,
            fill: black,
            style: "italic",
            [Email: sof\@ueh.edu.vn]
          )
        ]
      ]
    ]
  )
  // Course
  place(
    dx: 70mm,
    [
      #pad[
        #par(leading: 0.5em)[
          #text(
            size: 14pt,
            fill: black,
            style: "italic",
            [Tiểu luận kết thúc học phần]
          )
        ]
        #par(leading: 0.5em)[
          #text(
            size: 20pt,
            fill: black,
            [#subject],
            weight: "bold"
          )
        ]
      ]
    ]
  )
  // Title
  place(
    dx: 70mm, dy: 50mm,
    [
      #pad(right:70mm)[
        #par(leading: 1.5em)[
          #text(
            size: 22pt,
            fill: ueh-orange,
            strong(upper(title))
          )
        ]
      ]
    ]
  )
  // Author
  place(
    dx: 70mm, dy: 153mm,
    [
      #pad[
        #par(leading: 0.5em)[
          #text(size: 13pt, fill:black, style:"italic")[Học viên thực hiện]
        ]
      ]
    ]
  )
  place(
    dx: 70mm, dy: 150mm,
    if authors != none {
      let count = authors.len()
      let ncols = calc.min(count, 1)
      v(1cm)
      grid(
        columns: (1fr,) * ncols,
        row-gutter: 1.5em,
        ..authors.map(author =>
            align(left)[
              #text(size: 15pt, fill: black)[#author.name] \
              #text(size: 12pt, fill: black)[#author.email]
            ]
          )
        )
      }
  )
  // Instructors
  place(
    dx: 70mm, dy: 190mm,
    [
      #pad[
        #par(leading: 0.5em)[
          #text(
            size: 13pt,
            fill: black,
            style: "italic",
            [Giảng viên hướng dẫn]
          ) \
        ]
        #par(leading: 0.5em)[
          #text(
            size: 14pt,
            fill: black,
            [#instructors],
            weight: "bold"
          )
        ]
      ]
    ]
  )
  // City and Date
  place(
    dx: 83mm, dy: 230mm,
    [
      #pad[
        #par(leading: 0.5em)[
          #text(
            size: 13pt,
            fill: black,
            [TP. Hồ Chí Minh, #date],
            weight: "bold"
          )
        ]
      ]
    ] 
  )
  //
  //
  //
  // Main Content
  //
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)
  
  // Abstract
  //
  // Title
  if title != none {
    align(center)[#block(inset: 2em)[
      #text(weight: "bold", size: 1.5em)[#title]
    ]]
  }
  // Date
  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }
  // Abstract Content
  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[$labels.abstract$] #h(1em) #abstract
    ]
  }
  // Break
  pagebreak(weak: true)
  
  // Table of Contents
  //
  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }
  // Break
  pagebreak(weak: true)
  
  // Main
  //
  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none
)