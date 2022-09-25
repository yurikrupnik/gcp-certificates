package go_user_model

import (
	"testing"
)

func TestUserModel(t *testing.T) {
	result := UserModel("works")
	if result != "UserModel works" {
		t.Error("Expected UserModel to append 'works'")
	}
}
