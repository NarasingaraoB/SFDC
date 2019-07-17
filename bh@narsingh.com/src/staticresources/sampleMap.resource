<html>
<head>
<title>
map design
</title>
<script type="text/javascript">
sourceImage=new Image();
function changeImage(target,image)
{
sourceImage.src=image;
document.getElementById(target).src=sourceImage.src;

}
</script>
</head>
<body>
<!--<img src="bild.png" usemap="#Tutorial"/>
<map name="Tutorial">
<area shape="poly" coords="120,199,274,21,345,249,481,173,391,371" href="http://www.google.co.in"/>
</map>
-->
<img src="india.png" width="516" height="700"  border="0" style="z-index:0;position:absolute;top:0px;left:0px"/>
<img src="inTrans.png" id="ind" style="z-index:1;position:absolute;top:0px;left:0px" usemap="#map"/>
<map name="map">
<area shape="poly" coords="214,510,210,510,204,515,198,514,193,519,186,519,176,526,173,524,181,513,177,512,178,508,173,507,173,502,165,501,165,504,161,506,157,500,159,493,152,492,147,485,148,478,153,478,153,472,154,458,164,461,173,461,175,458,185,459,189,454,195,455,195,449,208,447,213,440,216,440,217,445,220,444,219,437,225,440,236,436,241,426,249,421,254,422,256,411,259,413,260,417,263,414,266,415,268,407,274,406,276,400,283,405,288,407,294,404,299,399,289,414,270,430,253,441,255,450,243,454,235,454,229,466,224,464,215,467,211,484,215,511" href="Ap.html" onmouseover="changeImage('ind','Ap.png');" onmouseout="changeImage('ind','inTrans.png');"/>

</map>

</body>
</html>
