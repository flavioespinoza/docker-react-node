import React, { Component } from "react";
import "bulma/css/bulma.css";
import "./Hero.scss";

const request = require("request");

class Hero extends Component {
  constructor(props) {
    super(props);
    this.state = {
			email: 'user not logged in',
			success: 'False',
    };
    this.loginClick = this.loginClick.bind(this);
    this._openid = this._openid.bind(this);
  }

  componentDidMount() {}

  loginClick() {
		const qs = {
			email: 'flavio.espinoza@gmail.com',
			// email: 'balls@gmail.com',
		}
		this._openid(qs)
	}

  _openid(qs) {
		const _self = this
		const options = {
			method: "POST",
			url: "http://localhost:8080/api/openid-login",
			qs: qs
		};
		request(options, function(error, response, body) {
			if (error) throw new Error(error);
			const _body = JSON.parse(body);
			console.log(_body);
			_self.setState({
				email: _body.email,
				success: 'True'
			})
		});
  }

  render() {
    return (
      <section className="hero is-info docker-react-node__app">
        <div className="hero-body">
          <div className="container">
            <h1 className="title">Dockerized React Node App HERO BALLS</h1>
            <button onClick={this.loginClick}>OpenID Login Hello</button>
						<h4>EMAIL: {this.state.email}</h4>
						<h4>SUCCESS: {this.state.success}</h4>
          </div>
        </div>
      </section>
    );
  }
}

export default Hero;
