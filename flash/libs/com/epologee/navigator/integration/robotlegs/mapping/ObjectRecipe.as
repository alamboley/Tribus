package com.epologee.navigator.integration.robotlegs.mapping {
	import com.epologee.development.logging.logger;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class ObjectRecipe {
		public var ObjectClass : Class;
		public var params : Array;
		//
		private var _object : *;

		public function ObjectRecipe(objectClass : Class, constructorParams : Array) {
			ObjectClass = objectClass;
			params = constructorParams;
		}

		public function get instantiated() : Boolean {
			return _object != null;
		}

		/**
		 * Lazily instantiates the product.
		 */
		public function get object() : * {
			if (!_object) {
				switch(params.length) {
					default:
					case 0:
						_object = new ObjectClass();
						break;
					case 1:
						_object = new ObjectClass(params[0]);
						break;
					case 2:
						_object = new ObjectClass(params[0], params[1]);
						break;
					case 3:
						_object = new ObjectClass(params[0], params[1], params[2]);
						break;
					case 4:
						_object = new ObjectClass(params[0], params[1], params[2], params[3]);
						break;
					case 5:
						_object = new ObjectClass(params[0], params[1], params[2], params[3], params[4]);
						break;
					case 6:
						_object = new ObjectClass(params[0], params[1], params[2], params[3], params[4], params[5]);
						break;
					case 7:
						_object = new ObjectClass(params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
						break;
					case 8:
						_object = new ObjectClass(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
						break;
					case 9:
						_object = new ObjectClass(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
						break;
					case 10:
						_object = new ObjectClass(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8], params[9]);
				}

				logger.info("Instantiated "+_object);
			}

			return _object;
		}

		public function toString() : String {
			return "[ObjectRecipe " + getQualifiedClassName(ObjectClass) + "]";
		}
	}
}
