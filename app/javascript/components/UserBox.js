import React from "react"
import PropTypes from "prop-types"
import Sticky from "./Sticky"

class UserBox extends React.Component {

  constructor(props) {
    super(props);

    var tasks = this.props.user.tasks ? this.props.user.tasks : {};

    this.state = { tasks: tasks };

    this.onDrop = this.onDrop.bind(this);
    this.updateTaskList = this.updateTaskList.bind(this);
    this.preventDefault = this.preventDefault.bind(this);

    this.props.dropHandlerRegister(this.props.user.id, this.updateTaskList);
  }

  preventDefault(event) {
    event.preventDefault();
  }

  onDrop(event) {
    var dropData = JSON.parse(event.dataTransfer.getData('text/plain'));

    this.props.onTaskDrop(dropData.now_user_id, this.props.user.id, dropData.task);
  }

  updateTaskList(prev_user_id, next_user_id, task) {
    if (prev_user_id == next_user_id) {
      return;
    }

    if (prev_user_id == this.props.user.id) {
      this.deleteTask(task.id);
    }

    if (next_user_id == this.props.user.id) {
      this.addTask(task);
    } 
  }

  deleteTask(task_id) {
    var tasks = this.state.tasks;

    delete tasks[task_id];

    this.setState({tasks: tasks});
  }

  addTask(task) {
    var tasks = this.state.tasks;

    tasks[task.id] = task;

    this.setState({tasks: tasks});
  }

  render () {
    return (
      <React.Fragment>
        <div id={"user-" + this.props.user.id} className="UserBox" onDrop={this.onDrop} onDragOver={this.preventDefault} >
          <div className="UserName">{this.props.user.name}</div>
          <div className="TaskArea">
            { Object.keys(this.state.tasks).map((key) => <Sticky user_id={this.props.user.id} task={ this.state.tasks[key] } key={ key } /> ) }
          </div>
        </div>
      </React.Fragment>
    );
  }
}

export default UserBox