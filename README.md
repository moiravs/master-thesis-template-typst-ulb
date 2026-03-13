# master-thesis-template-typst-ulb

Hello, this is my template for the master thesis at ULB in typst.

To use it, you only need to download the template.typ and download the image of the ulb logo on the website of the master thesis.

Then, in your main.typ, you need to put this at the beginning of your file:

```typ
#import "template.typ": *
#show: doc => styling(doc) // to modify the font, the margins and all that stuff
#title_page(author: "Author of the thesis", advisor: "Advisor", promotor: "Promotor", title: "Your title") // the front page
#outline(title: text(size: 1.5em, font: "New Computer Modern")[Contents], indent: auto) // the outline
#pagebreak()
```

# Other functions not necessary but kinda cool to use

I also made a function to make equations easy:

```typ
#equation(
  "The Rendering Equation", // title of the equation
  [$ underbrace(L_o (x, w_o, lambda, t), "Outgoing Light") = underbrace(L_e (x, w_o, lambda, t), "Emitted Light") + underbrace(L_r (x, w_o, lambda, t), "Reflected Light") $ 
      $ L_r(x, omega_o, lambda, t) = integral _Omega underbrace(f_r(x, omega_i, omega_o, lambda, t), "BRDF") dot.c underbrace(L_i(x, omega_i, lambda, t), "Incoming Light") dot.c underbrace(cos theta_i, "Angle") d omega_i $], // the equation
    lab: "eqt:rendering_eqt" // the label of the equation for reference
) 

```
