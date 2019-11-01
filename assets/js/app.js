// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";
import $ from 'jquery';
import _ from 'lodash';

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

function show_tag(photo_id, tag) {
  let cards = $('.photo-tags');
  let base = _.find(cards, (xx) => $(xx).data('photo-id') == photo_id);
  let list = $(base).find('.tag-list');

  for (let pp of list.find('.badge')) {
    if ($(pp).data('tag-id') == tag.tag_id) {
      return;
    }
  }

  list.append(tag.html);

  list = $(base).find('.tag-list');

  for (let pp of list.find('.badge')) {
    if ($(pp).data('tag-id') == tag.tag_id) {
      $(pp).find('.tag-delete').on("click", remove_click);
    }
  }

  console.log("shown", photo_id, tag);
}

function add_tag(photo_id, tag) {
  let data = {photo_tag: {photo_id: photo_id, tag_name: tag}};
  $.ajax("/ajax/photo_tags", {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: JSON.stringify(data),
    headers: {
      'x-csrf-token': window.csrf_token,
    },
    success: (resp) => {
      console.log(resp);
      show_tag(photo_id, resp.data);
    },
    error: (resp) => {
      console.log(resp);
      console.log(resp.responseText);
    }
  });
}

function remove_click(ev) {
  ev.preventDefault();

  let tag = $(ev.target).parent();
  let photo_tag_id = tag.data('photo-tag-id');

  $.ajax("/ajax/photo_tags/"+photo_tag_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    headers: {
      'x-csrf-token': window.csrf_token,
    },
    success: (resp) => {
      console.log("tag removed", resp);
      tag.remove();
    },
    error: (resp) => {
      console.log(resp);
      console.log(resp.responseText);
    }
  });
}

function init_tags() {
  $('.photo-tags').each((_, base) => {
    let photo_id = $(base).data('photo-id');
    let button = $(base).find('.add-tag-btn');
    let input = $(base).find('input');

    let submit = (_ev) => {
      let tag = input.val();
      add_tag(photo_id, tag);
    };

    button.on("click", submit);
    input.on("keypress", (ev) => {
      if (ev.key == "Enter") {
        submit(ev);
      }
    });

    $(base).find('.tag-delete').on("click", remove_click);
  });
}

$(init_tags);
