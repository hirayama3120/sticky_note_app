import React from "react"
import PropTypes from "prop-types"

import UserBox from "./UserBox"

class WhiteBoard extends React.Component {
  constructor(props) {
    super(props);

    this.state = { users: {}, loading: true, dropHandlers: {}, need_render: false };

    this.dropHandlerRegister = this.dropHandlerRegister.bind(this);
    this.onTaskDrop = this.onTaskDrop.bind(this);

  }

  componentDidMount() {
    this.getData();
  }

  shouldComponentUpdate(nextProps, nextState){
    if (nextState.need_render) {
      return true;
    }

    console.log("** skip rendering **");
    return false;

  }

  getData() {
    fetch(this.props.user_tasks_url)
      .then((response) => response.json())
      .then((json) => {
        this.setState({users: json.users, loading: false, need_render: true});
      })
      .catch((response) => {
        console.log('** error **');
      })
  }

  callSwitchUser(task_id, user_id) {
    var switch_info = { switch_info: { task_id: task_id, user_id: user_id } };

    fetch(this.props.switch_user_url, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "X-CSRF-Token": this.props.secure_token
      },
      body: JSON.stringify(switch_info)
    })
    .then(response => response.json())
    .then(json => console.log(JSON.stringify(json)))
    .catch(error_response => console.log(error_response));

  }

  dropHandlerRegister(user_id, func) {
    var handlers = this.state.dropHandlers;

    if ( ! handlers[user_id] ) {
      handlers[user_id] = func;
      this.setState({dropHandlers: handlers, need_render: false});
    }

  }

  onTaskDrop(prev_user_id, next_user_id, task) {
    Object.keys(this.state.dropHandlers).map((key) => {
      this.state.dropHandlers[key](prev_user_id, next_user_id, task);
    });

    this.callSwitchUser(task.id, next_user_id);

  }

  addUser() {
    fetch(this.props.add_user_url, {
      method: "POST"
    })
    .then(response => response.json())
    .then(json => console.log(JSON.stringify(json)))
    .then(response => this.getData())
    .catch(error_response => console.log(error_response));
  }

  render () {
    return (
      <React.Fragment>
        <div id="WhiteBoardTitle">{this.props.title}</div>
        <div id="AddButton" >
          <button type="submit" onClick={this.addUser.bind(this)}>Add User</button>
        </div>
        <div id="WhiteBoard">
          { ! this.state.loading && this.state.users.map((user) => <UserBox user={user} key={user.id} dropHandlerRegister={this.dropHandlerRegister} onTaskDrop={this.onTaskDrop} addUser={this.addUser}/> )}
        </div>
      </React.Fragment>
    );
  }
}

export default WhiteBoard