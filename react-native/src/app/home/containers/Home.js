import React, { Component, StyleSheet, Text, View, TouchableOpacity } from 'react-native';

export default class App extends Component {
  componentDidMount() {
  }

  toPost() {
    this.props.router.push('post');
  }

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity onPress={this.toPost.bind(this)}>
            <Text>Goasefsaf!!</Text>
        </TouchableOpacity>
      </View>
    );
  }
}

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
});


