/**
 * Copyright (c) 2012 Stephan Partzsch
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *  
 * @author Stephan Partzsch
 * http://www.stephan-partzsch.de
 */
package de.stephanpartzsch.ui.shared
{
	import flash.accessibility.AccessibilityImplementation;
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.geom.Vector3D;
	import flash.media.SoundTransform;
	import flash.text.TextSnapshot;
	import flash.ui.ContextMenu;
	
	/**
	 * Creates an interface so that any objects that inherits from the 
	 * <code>MovieClipDelegator</code> is able to delegate every call to any 
	 * method and any property of type MovieClip to a given MovieClip instance.
	 */
	public class MovieClipDelegator extends MovieClip
	{
		/**
		 * The instance of type MovieClip to which every call is delegated.
		 */	
		protected var movieClip : MovieClip;
				
		/**
		 * Adds a instance of type MovieClip to this MovieClipDelegator. 
		 * Optionally this instance can be added as a child to the display 
		 * list of the super class.
		 * 
		 * @param movieClipInstance The instance of type MovieClip to which every call is delegated.
		 * @param addToDisplayList If <code>movieClipInstance</code> should be added to the display list of the super class. Default is <code>false</code>.
		 * 
		 * @throws ArgumentError If the given movieClipInstance is <code>null</code>.
		 */				
		public function addMovieClip( movieClipInstance : MovieClip, addToDisplayList : Boolean = false ) : void
		{
			if( movieClipInstance == null )
				throw new ArgumentError( "The movieClipInstance must not be null." );
			
			movieClip = movieClipInstance;
			
			if( addToDisplayList == true )
				super.addChild( movieClip );
		}
		
		/**
		 * Disposes this MovieClipDelegator. It removes the MovieClip 
		 * instance from the display list of the super class if necessry.
		 */	
		public function dispose() : void
		{
			if( super.contains( movieClip ) )
				super.removeChild( movieClip );
			
			movieClip = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set accessibilityImplementation( value : AccessibilityImplementation ) : void 
		{
			movieClip.accessibilityImplementation = value;
		}

		/**
		 * @inheritDoc
		 */
		[Inspectable(environment="none")]
		public override function get accessibilityImplementation() : AccessibilityImplementation 
		{
			return movieClip.accessibilityImplementation;
		}

		/**
		 * @inheritDoc
		 */
		public override function set accessibilityProperties( value : AccessibilityProperties ) : void 
		{
			movieClip.accessibilityProperties = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get accessibilityProperties() : AccessibilityProperties 
		{
			return movieClip.accessibilityProperties;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set alpha( value : Number ) : void 
		{
			movieClip.alpha = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get alpha() : Number 
		{
			return movieClip.alpha;
		}
		
		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function set blendShader( value : Shader ) : void 
		{
			movieClip.blendShader = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set blendMode( value : String ) : void 
		{
			movieClip.blendMode = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get blendMode() : String 
		{
			return movieClip.blendMode;
		}

		/**
		 * @inheritDoc
		 */
		public override function set buttonMode( value : Boolean ) : void
		{
			movieClip.buttonMode = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get buttonMode() : Boolean
		{
			return movieClip.buttonMode;
		}
		
		public override function set cacheAsBitmap( value : Boolean ) : void 
		{
			movieClip.cacheAsBitmap = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get cacheAsBitmap() : Boolean 
		{
			return movieClip.cacheAsBitmap;
		}

		/**
		 * @inheritDoc
		 */
		public override function set contextMenu( cm : ContextMenu ) : void 
		{
			movieClip.contextMenu = cm;
		}

		/**
		 * @inheritDoc
		 */
		public override function get contextMenu() : ContextMenu 
		{
			return movieClip.contextMenu;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get currentFrame() : int 
		{
			return movieClip.currentFrame;
		}

		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function get currentFrameLabel() : String 
		{
			return movieClip.currentFrameLabel;
		}

		/**
		 * @inheritDoc
		 */
		public override function get currentLabel() : String 
		{
			return movieClip.currentLabel;
		}

		/**
		 * @inheritDoc
		 */
		public override function get currentLabels() : Array 
		{
			return movieClip.currentLabels;
		}

		/**
		 * @inheritDoc
		 */
		public override function get currentScene() : Scene 
		{
			return movieClip.currentScene;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set doubleClickEnabled( enabled : Boolean ) : void
		{
			movieClip.doubleClickEnabled = enabled;
		}
				
		/**
		 * @inheritDoc
		 */
		public override function get doubleClickEnabled() : Boolean
		{
			return movieClip.doubleClickEnabled;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get dropTarget() : DisplayObject
		{
			return movieClip.dropTarget;
		}

		/**
		 * @inheritDoc
		 */
		public override function set enabled( value : Boolean ) : void 
		{
			movieClip.enabled = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get enabled() : Boolean 
		{
			return movieClip.enabled;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set filters( value : Array ) : void
		{
			movieClip.filters = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get filters() : Array
		{
			return movieClip.filters;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set focusRect( focusRect : Object ) : void
		{
			movieClip.focusRect = focusRect;
		}
	
		/**
		 * @inheritDoc
		 */
		public override function get focusRect() : Object
		{
			return movieClip.focusRect;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get framesLoaded() : int 
		{
			return movieClip.framesLoaded;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get graphics() : Graphics 
		{
			return graphics;
		}

		/**
		 * @inheritDoc
		 */
		public override function set height( value : Number ) : void 
		{
			movieClip.height = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get height() : Number 
		{
			return movieClip.height;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set hitArea( value : Sprite ) : void
		{
			movieClip.hitArea = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get hitArea() : Sprite
		{
			return movieClip.hitArea;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get loaderInfo() : LoaderInfo 
		{
			return movieClip.loaderInfo;
		}

		/**
		 * @inheritDoc
		 */
		public override function set mask( value : DisplayObject ) : void 
		{
			movieClip.mask = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get mask() : DisplayObject 
		{
			return movieClip.mask;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set mouseChildren( enable : Boolean ) : void
		{
			movieClip.mouseChildren = enable;
		}

		/**
		 * @inheritDoc
		 */
		public override function get mouseChildren() : Boolean
		{
			return movieClip.mouseChildren;
		}

		/**
		 * @inheritDoc
		 */
		public override function set mouseEnabled( enabled : Boolean ) : void
		{
			movieClip.mouseEnabled = enabled;
		}

		/**
		 * @inheritDoc
		 */
		public override function get mouseEnabled() : Boolean
		{
			return movieClip.mouseEnabled;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get mouseX() : Number 
		{
			return movieClip.mouseX;
		}

		/**
		 * @inheritDoc
		 */
		public override function get mouseY() : Number 
		{
			return movieClip.mouseY;
		}

		/**
		 * @inheritDoc
		 */
		public override function set name( value : String ) : void 
		{
			movieClip.name = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get name() : String 
		{
			return movieClip.name;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get numChildren() : int
		{
			return numChildren;
		}

		/**
		 * @inheritDoc
		 */
		public override function set opaqueBackground( value : Object ) : void 
		{
			movieClip.opaqueBackground = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get opaqueBackground() : Object 
		{
			return movieClip.opaqueBackground;
		}

		/**
		 * @inheritDoc
		 */
		public override function get parent() : DisplayObjectContainer 
		{
			return movieClip.parent;
		}

		/**
		 * @inheritDoc
		 */
		public override function get root() : DisplayObject 
		{
			return movieClip.root;
		}

		/**
		 * @inheritDoc
		 */
		public override function set rotation( value : Number ) : void 
		{
			movieClip.rotation = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get rotation() : Number 
		{
			return movieClip.rotation;
		}

		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function set rotationX( value : Number ) : void 
		{
			movieClip.rotationX = value;
		}

		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function get rotationX() : Number 
		{
			return movieClip.rotationX;
		}

		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function set rotationY( value : Number ) : void 
		{
			movieClip.rotationY = value;
		}

		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function get rotationY() : Number 
		{
			return movieClip.rotationY;
		}

		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function set rotationZ( value : Number ) : void 
		{
			movieClip.rotationZ = value;
		}

		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function get rotationZ() : Number 
		{
			return movieClip.rotationZ;
		}

		/**
		 * @inheritDoc
		 */
		public override function set scale9Grid( innerRectangle : Rectangle ) : void 
		{
			movieClip.scale9Grid = innerRectangle;
		}

		/**
		 * @inheritDoc
		 */
		public override function get scale9Grid() : Rectangle 
		{
			return movieClip.scale9Grid;
		}

		/**
		 * @inheritDoc
		 */
		public override function set scaleX( value : Number ) : void 
		{
			movieClip.scaleX = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get scaleX() : Number 
		{
			return movieClip.scaleX;
		}

		/**
		 * @inheritDoc
		 */
		public override function set scaleY( value : Number ) : void 
		{
			movieClip.scaleY = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get scaleY() : Number 
		{
			return movieClip.scaleY;
		}

		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function set scaleZ( value : Number ) : void 
		{
			movieClip.scaleZ = value;
		}

		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function get scaleZ() : Number 
		{
			return movieClip.scaleZ;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get scenes() : Array 
		{
			return movieClip.scenes;
		}

		/**
		 * @inheritDoc
		 */
		public override function set scrollRect( value : Rectangle ) : void 
		{
			movieClip.scrollRect = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get scrollRect() : Rectangle 
		{
			return movieClip.scrollRect;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set soundTransform( sndTransform : SoundTransform ) : void
		{
			movieClip.soundTransform = sndTransform;
		}

		/**
		 * @inheritDoc
		 */
		public override function get soundTransform() : SoundTransform
		{
			return movieClip.soundTransform;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get stage() : Stage 
		{
			return movieClip.stage;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set tabChildren( enable : Boolean ) : void
		{
			movieClip.tabChildren = enable;
		}

		/**
		 * @inheritDoc
		 */
		public override function get tabChildren() : Boolean
		{
			return movieClip.tabChildren;
		}

		/**
		 * @inheritDoc
		 */
		public override function set tabEnabled( enabled : Boolean ) : void
		{
			movieClip.tabEnabled = enabled;
		}

		/**
		 * @inheritDoc
		 */
		public override function get tabEnabled() : Boolean
		{
			return movieClip.tabEnabled;
		}

		/**
		 * @inheritDoc
		 */
		public override function set tabIndex( index : int ) : void
		{
			movieClip.tabIndex = index;
		}

		/**
		 * @inheritDoc
		 */
		public override function get tabIndex() : int
		{
			return movieClip.tabIndex;
		}

		/**
		 * @inheritDoc
		 */
		public override function get textSnapshot() : TextSnapshot
		{
			return movieClip.textSnapshot;
		}

		/**
		 * @inheritDoc
		 */
		public override function get totalFrames() : int
		{
			return movieClip.totalFrames;
		}

		/**
		 * @inheritDoc
		 */
		public override function set trackAsMenu( value : Boolean ) : void
		{
			movieClip.trackAsMenu = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get trackAsMenu() : Boolean
		{
			return movieClip.trackAsMenu;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set transform( value : Transform ) : void 
		{
			movieClip.transform = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get transform() : Transform 
		{
			return movieClip.transform;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set useHandCursor( value : Boolean ) : void
		{
			movieClip.useHandCursor = value;
		}

		/**
		 * @inheritDoc
		 */
		public override function get useHandCursor() : Boolean
		{
			return movieClip.useHandCursor;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set visible( value : Boolean ) : void 
		{
			movieClip.visible = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get visible() : Boolean 
		{
			return movieClip.visible;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set width( value : Number ) : void 
		{
			movieClip.width = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get width() : Number 
		{
			return movieClip.width;
		}
					
		/**
		 * @inheritDoc
		 */
		public override function set x (value : Number ) : void 
		{
			movieClip.x = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get x() : Number 
		{
			return movieClip.x;
		}

		/**
		 * @inheritDoc
		 */
		public override function set y( value : Number ) : void 
		{
			movieClip.y = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get y() : Number 
		{
			return movieClip.y;
		}

		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function set z( value : Number ) : void 
		{
			movieClip.z = value;
		}
		
		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function get z() : Number 
		{
			return movieClip.z;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function addChild( child : DisplayObject ) : DisplayObject
		{
			return movieClip.addChild( child );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function addChildAt( child : DisplayObject, index : int ) : DisplayObject
		{
			return movieClip.addChildAt( child, index );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function addEventListener( type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false ) : void 
		{
			movieClip.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/**
		 * @inheritDoc
		 */
		[Inspectable(environment="none")]
		public override function addFrameScript( ...args : * ) : void
		{
			movieClip.addFrameScript.apply( this, args );
		}

		/**
		 * @inheritDoc
		 */
		public override function areInaccessibleObjectsUnderPoint( point : Point ) : Boolean
		{
			return movieClip.areInaccessibleObjectsUnderPoint( point );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function contains( child : DisplayObject ) : Boolean
		{
			return movieClip.contains( child );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function dispatchEvent( event : Event ) : Boolean 
		{
			return movieClip.dispatchEvent( event );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getBounds( targetCoordinateSpace : DisplayObject ) : Rectangle
		{
			return movieClip.getBounds( targetCoordinateSpace );
		}

		/**
		 * @inheritDoc
		 */
		public override function getChildAt( index : int ) : DisplayObject
		{
			return movieClip.getChildAt( index );
		}

		/**
		 * @inheritDoc
		 */
		public override function getChildByName( name : String ) : DisplayObject
		{
			return movieClip.getChildByName( name );
		}

		/**
		 * @inheritDoc
		 */
		public override function getChildIndex( child : DisplayObject ) : int
		{
			return movieClip.getChildIndex( child );
		}

		/**
		 * @inheritDoc
		 */
		public override function getObjectsUnderPoint( point : Point ) : Array
		{
			return movieClip.getObjectsUnderPoint( point );
		}

		/**
		 * @inheritDoc
		 */
		public override function getRect( targetCoordinateSpace : DisplayObject ) : Rectangle
		{
			return movieClip.getRect( targetCoordinateSpace );
		}

		/**
		 * @inheritDoc
		 */
		public override function globalToLocal( point : Point ) : Point
		{
			return movieClip.globalToLocal( point );
		}

		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function globalToLocal3D( point : Point ) : Vector3D
		{
			return movieClip.globalToLocal3D( point );
		}

		/**
		 * @inheritDoc
		 */
		public override function gotoAndPlay( frame : Object, scene : String = null ) : void
		{
			movieClip.gotoAndPlay( frame, scene );
		}

		/**
		 * @inheritDoc
		 */
		public override function gotoAndStop( frame : Object, scene : String = null ) : void
		{
			movieClip.gotoAndStop( frame, scene );
		}

		/**
		 * @inheritDoc
		 */
		public override function hasEventListener( type : String ) : Boolean 
		{
			return movieClip.hasEventListener( type );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function hitTestObject( obj : DisplayObject ) : Boolean
		{
			return movieClip.hitTestObject( obj );
		}

		/**
		 * @inheritDoc
		 */
		public override function hitTestPoint( x : Number, y : Number, shapeFlag : Boolean = false ) : Boolean
		{
			return movieClip.hitTestPoint( x, y, shapeFlag );
		}

		/**
		 * @inheritDoc
		 */
		[Version("10")]
		public override function local3DToGlobal( point3d : Vector3D ) : Point
		{
			return movieClip.local3DToGlobal( point3d );
		}

		/**
		 * @inheritDoc
		 */
		public override function localToGlobal( point : Point ) : Point
		{
			return movieClip.localToGlobal( point );
		}

		/**
		 * @inheritDoc
		 */
		public override function nextFrame() : void
		{
			movieClip.nextFrame();
		}

		/**
		 * @inheritDoc
		 */
		public override function nextScene() : void
		{
			movieClip.nextScene();
		}

		/**
		 * @inheritDoc
		 */
		public override function play() : void
		{
			movieClip.play();
		}

		/**
		 * @inheritDoc
		 */
		public override function prevFrame() : void
		{
			movieClip.prevFrame();
		}

		/**
		 * @inheritDoc
		 */
		public override function prevScene() : void
		{
			movieClip.prevScene();
		}

		/**
		 * @inheritDoc
		 */
		public override function removeChild( child : DisplayObject ) : DisplayObject
		{
			return movieClip.removeChild( child );
		}

		/**
		 * @inheritDoc
		 */
		public override function removeChildAt( index : int ) : DisplayObject
		{
			return movieClip.removeChildAt( index );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function removeEventListener( type : String, listener : Function, useCapture : Boolean = false ) : void 
		{
			movieClip.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * @inheritDoc
		 */
		public override function setChildIndex( child : DisplayObject, index : int ) : void
		{
			movieClip.setChildIndex( child, index );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function startDrag( lockCenter : Boolean = false, bounds : Rectangle = null ) : void
		{
			movieClip.startDrag( lockCenter, bounds );
		}

		/**
		 * @inheritDoc
		 */
		[API("667")]
		public override function startTouchDrag( touchPointID : int, lockCenter : Boolean = false, bounds : Rectangle = null ) : void
		{
			movieClip.startTouchDrag( touchPointID, lockCenter, bounds );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function stop() : void
		{
			movieClip.stop();
		}

		/**
		 * @inheritDoc
		 */
		public override function stopDrag() : void
		{
			movieClip.stopDrag();
		}

		/**
		 * @inheritDoc
		 */
		[API("667")]
		public override function stopTouchDrag( touchPointID : int ) : void
		{
			movieClip.stopTouchDrag( touchPointID );
		}

		/**
		 * @inheritDoc
		 */
		public override function swapChildren( child1 : DisplayObject, child2 : DisplayObject ) : void
		{
			movieClip.swapChildren( child1, child2 );
		}

		/**
		 * @inheritDoc
		 */
		public override function swapChildrenAt( index1 : int, index2 : int ) : void
		{
			movieClip.swapChildrenAt( index1, index2 );
		}
				
		/**
		 * @inheritDoc
		 */
		public override function toString() : String
		{
			return movieClip.toString();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function willTrigger( type : String ) : Boolean 
		{
			return movieClip.willTrigger(type);
		}		
	}
}