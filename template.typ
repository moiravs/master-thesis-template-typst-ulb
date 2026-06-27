


#let styling(it) = {
/////////////////////////////////////
// Page
/////////////////////////////////////
set page(
  paper: "a4",
  number-align: center,
  margin: 85pt,
)

set heading(numbering: "1.1 ", supplement: [Chapter])

set text(font: "New Computer Modern")


/////////////////////////////////////
// Outline
/////////////////////////////////////

show link: set text(fill: blue)
show outline.entry.where(): it => {
  text(size: 15pt)[#it]}
show outline.entry.where(level: 1): set text(weight: "bold")
show outline.entry.where(level: 1): set outline.entry(fill: none)
show outline.entry.where(level: 1): it => {
   v(0.7em)
   it
}

show outline.entry: it => {
  let no-nums = query(label("abbr"))
  let no-nums2 = query(label("ack"))
  if it.element in no-nums or it.element in no-nums2 {
  
  } else {
    it
  }
}


/////////////////////////////////////
// Heading
/////////////////////////////////////
set par(first-line-indent: 1.5em)
show selector.or(heading, table, grid, figure): it => {
    it
    ""
    context v(-par.spacing - measure("").height)
}
set heading(numbering: "1.1 ")

show heading.where(level: 1): it => {  
  if counter(heading).display() != "0"  {
    // Use the heading's custom supplement if set, otherwise default to "Chapter"
    let prefix = if it.supplement == auto [Chapter] else { it.supplement }
    
    pagebreak()
    grid(
        columns: (1fr),
        row-gutter: 1.2em,
        [#text(size: 1.3em)[#prefix #counter(heading).display()]],
        text(size: 1.5em)[#it.body],
        []
    )
  } else {
    text(size: 1.5em)[#it.body] 
    "\n"
  }
}

set heading(numbering: "1.1 ")

show bibliography: set heading(numbering: none, outlined: false)

/////////////////////////////////////
// Equation
/////////////////////////////////////

show math.equation: set text(11pt)

/////////////////////////////////////
// Equation
/////////////////////////////////////
show figure.caption: it => {
   v(0.7em)
   it
}
show figure: it => {
  v(0.5em)
  it
  "\n"
}
it


}




#let title_page(author: "", advisor: "", promotor: "", title: "") = {
  text(size: 16pt)[Faculty of sciences  #h(1fr) Department of Computer Science]
v(1fr)
align(center )[#image("sceau-a-quadri.jpg", width: 40%)]
v(1fr)


align(center + horizon)[
#line(length: 100%, stroke: 2pt)
#text(size: 34pt)[#title]
#line(length: 100%, stroke: 2pt)
]

v(1fr)
align(center)[
  #text(size: 18pt)[
  Author: #author \
  Advisor: #advisor \
  Promotor: #promotor \

\
  Academic year 2024-2025
  #v(1fr)
]
]

pagebreak()
}

#let equation(title, equation, lab: " ") = context {
import "@preview/showybox:2.0.4": showybox

  // Query for the equation to be placed so that we can get
  // its location and its counter value.
  let eq = query(selector(math.equation).after(here())).at(0, default: none)
  let title = if eq != none {
    let nums = counter(figure.where(kind: "equation")).at(eq.location())
    [#eq.supplement #numbering("1.1", ..nums): #title]
  }

  

  // Hide the numbering in the equation itself.
  set math.equation(numbering: (..) => none)
  [#figure(
  showybox(
    title-style: (
      boxed-style: (anchor: (x: center, y: horizon), radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt)),
      color: black,
    ),
    frame: (
      title-color: blue.lighten(80%),
      body-color: blue.lighten(90%),
      border-color: navy.darken(20%),
      radius: (top-left: 10pt, bottom-right: 10pt, rest: 0pt),
    ),
    title: title,
    [#equation], // check equation
  ),
  kind: "equation",
  supplement: [Equation]
) 
#label(lab)
]


}


/////////////////////////////////////
// Acknowledgments
/////////////////////////////////////

#let acknowledgments(body) = {
  set heading(outlined: false, supplement: none, numbering: none)
  counter(heading).update(0)
  set page(numbering: "1")
  heading("Acknowledgments")
  body
}




/////////////////////////////////////
// Abbreviations
/////////////////////////////////////

#let abbreviations(body) = {
  set heading(outlined: false, supplement: none, numbering: none)
  counter(heading).update(0)
  set page(numbering: "1")
  heading("Abbreviations")
  body

  counter(heading).update(0)
set page(numbering: "1")
set math.equation(numbering: "(1)")
}


/////////////////////////////////////
// Appendix
/////////////////////////////////////

#let appendix(body) = {
  set heading(numbering: "A", supplement: [Appendix])
  counter(heading).update(0) // Resets the counter so it starts at A
  body
}