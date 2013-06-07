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

class ProgressItem : Box {
	private Spinner spinner 		= new Spinner();
	private Button cancel_button 	= new Button();

	public ProgressItem(int size = 25){
		GLib.Object(orientation: Orientation.HORIZONTAL, spacing: 3);
		this.get_style_context().add_class("progress-item");
		this.pack_start(spinner, true, true);
		cancel_button.image = new Image.from_stock(Stock.CANCEL, IconSize.LARGE_TOOLBAR);
		cancel_button.clicked.connect( () => {
			this.stop();
			this.parent.remove(this);
		});
		this.pack_start(cancel_button, false, false);
		this.border_width = 5;
		spinner.set_size_request(size, size);
		this.set_size_request(size, size);
	}



	public void start(){
		spinner.start();
	}

	public void stop(){
		spinner.stop();
	}
}