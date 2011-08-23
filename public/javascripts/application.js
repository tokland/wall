templates = {}

Application = Class.create({
  _toolbar: [
		{name: 'document', items: ['Preview']},
		{name: 'clipboard', items: ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo']},
		{name: 'editing', items: ['Find', 'Replace']},
		{name: 'insert', items: ['Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley']}, 
		{name: 'basicstyles', items: ['Bold', 'Italic', 'Strike', '-', 'RemoveFormat']},
		{name: 'paragraph', items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent','-', 'Blockquote']},
		{name: 'links', items: ['Link', 'Unlink']},
	],
	
  initialize: function(text_area_id, options) {
    this.editor = CKEDITOR.replace(text_area_id, {toolbar: this._toolbar});
    this.options = options;
    this.notes_state = options.notes_state;
    this.notes_path = options.notes_path
    this.setNotesUpdater(10.0);
    document.observe("dom:loaded", this.setCallbacks.bind(this));  
  },

  setCallbacks: function() {
    $("wall").on("click", ".add-attachment", function(ev) {
      var ul = ev.target.up("form").down(".attachments");
      var li = templates.attachment_item.interpolate(
        {child_index: new Date().getTime() + Math.random()}); 
      ul.insert({bottom: li});
      ev.stop();
    }.bind(this));

    $("wall").on("click", ".remove-attachment", function(ev) {
      ev.target.up("li").remove();
      ev.stop();
    }.bind(this));
      
    $("wall").on("ajax:success", '.note .delete', function(ev) {
      var note = ev.memo.responseJSON.note;
      //$("note-"+note.id).remove();
      this.syncNotes();
    }.bind(this));
  },


  newNoteInserted: function() {
    this.editor.setData("");
    var ul = $("new_note").down(".attachments");
    ul.update("");
    this.syncNotes();
  },
  
  syncNotes: function() {
    new Ajax.Request(this.notes_path, {
      method: 'POST',
      parameters: {state: Object.toJSON(this.notes_state)},
      onSuccess: function(transport) {
        var json = transport.responseJSON;
        this.updateNotes(json.notes);
        this.notes_state = json.state;
      }.bind(this)
    });
  },
  
  updateNotes: function(notes) {
    /* Insert new notes and update old ones */    
    notes.inject($("notes"), function(insertion_point, note) {
      var note_container = $("note-" + note.id);      
      if (!note.html) {
        return note_container;
      } else {      
        if (note_container) {
          note_container.replace(note.html);
          $("note-" + note.id).pulsate();
        } else {
          if (insertion_point.id == "notes") {
            insertion_point.insert({top: note.html});
          } else {
            insertion_point.insert({after: note.html});
          }
          note_container = $("note-" + note.id);
          note_container.slideDown();
        }
        return note_container;
      }
    }.bind(this));

    /* Remove non-existing notes */
    var note_ids = notes.pluck("id");
    $("notes").select(".note").each(function(note) {
      var note_id = note.id.split("-")[1];
      if (note_ids.indexOf(note_id) < 0) {
        note.fade();
      }
    });      
  },

  setNotesUpdater: function(interval) {
    new PeriodicalExecuter(function(pe) {
      this.syncNotes();
    }.bind(this), interval);
  }
});
