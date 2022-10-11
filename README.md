<html>
<head>
	<meta charset="utf-8" />
	<meta name="generator" content="R package animation 2.7">
	<title>Animations Using the R Language</title>
	<link rel="stylesheet" href="css/reset.css" />
	<link rel="stylesheet" href="css/styles.css" />
	<link rel="stylesheet" href="css/scianimator.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/8.3/styles/github.min.css">

	<script src="js/jquery-1.4.4.min.js"></script>
	<script src="js/jquery.scianimator.min.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/8.3/highlight.min.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/8.3/languages/r.min.js"></script>
  <script>hljs.initHighlightingOnLoad();</script>

</head>
<body>

	<div class="scianimator"><div id="MODIS_CO" style="display: inline-block;"></div></div>
	<div class="scianimator" style="width: 480px; text-align: left"><pre><code class="r">## Animations generated in R version 4.2.1 (2022-06-23)
##   using the package animation
library(animation)
library(ncdf4)
for (i in 1:365) image(colo[, , i], main = day0 + i)
## R version 4.2.1 (2022-06-23)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Other packages: animation 2.7, ncdf4 1.19</code></pre></div>
	<script src="js/MODIS_CO.js"></script>
<!-- highlight R code -->

</body>
</html>
