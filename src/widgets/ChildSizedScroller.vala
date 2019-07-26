/*  This file is part of corebird, a Gtk+ linux Twitter client.
 *  Copyright (C) 2018 IBBoard
 *
 *  corebird is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  corebird is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with corebird.  If not, see <http://www.gnu.org/licenses/>.
 */

class ChildSizedScroller : Gtk.ScrolledWindow {
    public override void get_preferred_height_for_width (int     width,
                                                         out int minimum,
                                                         out int natural) {
        int min = 0;
        int nat = 0;
        foreach (Gtk.Widget w in get_children()) {
            int m, n;
            w.get_preferred_height_for_width (width, out m, out n);
            min = int.max (m, min);
            nat = int.max (n, nat);
        }
        minimum = min;
        natural = nat;
    }

    public override void get_preferred_height (out int minimum,
                                               out int natural) {
        int min = 0;
        int nat = 0;
        foreach (Gtk.Widget w in get_children()) {
            int m, n;
            w.get_preferred_height (out m, out n);
            min = int.max (m, min);
            nat = int.max (n, nat);
        }
        minimum = min;
        natural = nat;
    }

    // Don't override get_preferred_width because we specifically *don't* want
    // the child's idea of width to stretch everything!
 }