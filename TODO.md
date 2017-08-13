TODO

- Rewrite the dichromat functions so they work with transparency
- Implement better model of color-deficient vision (CDV) than available in
  the dichromat package, using the theory explained here:
  http://www.inf.ufrgs.br/~oliveira/pubs_files/CVD_Simulation/CVD_Simulation.html
  (This model is also implemented in python here, for reference:
  https://github.com/njsmith/colorspacious/blob/master/colorspacious/cvd.py
  )
- Add a `desaturate` function that converts colors to grayscale
- Add convenience functions for things other than grobs, using the 
  cowplot::plot_to_gtable() function (needs to be exported from
  cowplot, though)
- Write a better vignette
