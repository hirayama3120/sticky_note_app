import React from "react"
import PropTypes from "prop-types"

class Sticky extends React.Component {
    constructor(props) {
        super(props);

        this.onDragStart = this.onDragStart.bind(this);

  }

    onDragStart(event) {
                var dragData = { now_user_id: this.props.user_id, task: this.props.task };
    event.dataTransfer.setData("text/plain", JSON.stringify(dragData));
  }

    render () {
    return (
      <React.Fragment>

        <div id={"task-" + this.props.task.id} className="Sticky" draggable="true" onDragStart={this.onDragStart} >
          <div className="TaskTitle">{this.props.task.title}</div>
          <div className="TaskDescription">{this.props.task.description}</div>
          <div className="TaskDueDate">{this.props.task.due_date}</div>
        </div>

      </React.Fragment>
    );
  }
}

export default Sticky