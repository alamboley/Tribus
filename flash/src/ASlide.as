﻿package  {		import com.epologee.navigator.behaviors.IHasStateInitialization;	import com.epologee.navigator.behaviors.IHasStateTransition;	import com.greensock.TweenMax;	import flash.display.MovieClip;		public class ASlide extends MovieClip implements IHasStateInitialization, IHasStateTransition {		public function ASlide(){		}		public function initialize() : void {			gotoAndStop(0);			alpha = 0;			visible = false;		}		public function transitionIn(inCallOnComplete : Function) : void {			TweenMax.to(this, 1, {autoAlpha:1, onComplete:inCallOnComplete});			play();		}		public function transitionOut(inCallOnComplete : Function) : void {			TweenMax.to(this, 1, {autoAlpha:0, onComplete:inCallOnComplete});			stop();		}	}	}