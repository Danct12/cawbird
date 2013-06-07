/*  This file is part of corebird.
 *
 *  Foobar is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Foobar is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with corebird.  If not, see <http://www.gnu.org/licenses/>.
 */
using Gtk;

const int TOP    = 1;
const int BOTTOM = 2;
const int NONE   = 0;

class ScrollWidget : ScrolledWindow {
	public signal void scrolled_to_start(double value);
	public signal void scrolled_to_end();
	private double upper_cache;
	private double value_cache;
	private int balance = NONE;
	public double end_diff {get; set; default = 150;}

	public ScrollWidget(){
		GLib.Object(hadjustment: null, vadjustment: null);
		vadjustment.notify["upper"].connect(keep_upper_func);
		vadjustment.notify["value"].connect(keep_value_func);

		this.kinetic_scrolling = true;
	}

	private void keep_upper_func() {
		double upper = vadjustment.upper;
		if (balance == TOP){
			double inc = (upper - upper_cache);

			this.vadjustment.value += inc;
			balance = NONE;
		}
		this.upper_cache = vadjustment.upper;
		this.value_cache = vadjustment.value;
	}

	private void keep_value_func () {
		// Call the scrolled_to_top signal if necessary
		if(vadjustment.value < 10)
			scrolled_to_start(vadjustment.value);

		double max = vadjustment.upper - vadjustment.page_size;
		if(vadjustment.value >= max - end_diff)
			scrolled_to_end();

		double upper = vadjustment.upper;
		if (balance == BOTTOM){
			double inc = (upper - upper_cache);

			this.vadjustment.value -= inc;
			balance = NONE;
		}
		this.upper_cache = vadjustment.upper;
		this.value_cache = vadjustment.value;
	}

	public void balance_next_upper_change(int mode){
		balance = mode;
	}

}
