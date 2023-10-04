
the cube is defined by:

Axis - a pair:
  list of axis names
  corresponding lists of axis labels
  - view as:
  ({.,.&>}.)Axis

Table - a triple
  list of axis names (same as 0 pick Axis)
  list of axis types (mostly 4=sym, else 2=numeric)
  list of axis values (each around 400K length)

Order - indices into Axis
  row indices
  col indices
  remaining indices
  list of selected indices or _1 if none

Piv - used to generate the Table, but not used thereafter
  it is Table without the data and in a different order

Method:
  Order determines what is shown.
  Axis/Table/Piv remain unchanged.
