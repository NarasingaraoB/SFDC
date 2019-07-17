 $(document).ready(function() {
		
		
    /* Next part of code handles hovering effect and submenu appearing */
    $('.nav li').hover(
      function () { //appearing on hover
        $('ul', this).fadeIn();
      },
      function () { //disappearing on hover
        $('ul', this).fadeOut();
      }
    );
 
   /** 
    * The first variable records which slide currently showing. The slideWidth variable is self explanatory. 
    * Next we have a variable called slides which lets us refer to our slides in the jQuery code and the last  
    * variable gives us the number of slides in our slideshow. 
    */
		var currPosition = 0;
		var slideWidth = 843;
		var slides = $('.slide');
		var numberOfSlides = slides.length;
		var slideInterval;
		var speed = 3000;
		
		
   /** 
    * To get the slides to line up across the page, we need to add another div. We're going to do this with jQuery.
    * This div will hold all the slides and allow the float:left property to work. 
    */
		slideInterval = setInterval(changePosition, speed);
		
		slides.wrapAll('<div id="slidesHolder"></div>')
		
		slides.css({ 'float' : 'left' });
		
		$('#slidesHolder').css('width', slideWidth * numberOfSlides);
		
				
	/**
   * The first part of the if/else statement deals with when reach the end of the slide show.
   * When we come to the last slide we want to jump back to the beginning, otherwise the currentSlide
   * variable is simply incremented by 1 and then another function moveSlide is called. 
   */
		function changePosition() {
			if(currPosition == numberOfSlides - 1) {
				currPosition = 0;
			} else {
				currPosition++;
			}
			moveSlide();
		}
		
    
   /**
		* This function sets the left margin of the slidesHolder div to the width of the slide multiplied by
    * the slide number and then animates to that from the current left margin 
    */
		function moveSlide() {
				$('#slidesHolder')
				.animate({'marginLeft' : slideWidth*(-currPosition)});
		}

	});