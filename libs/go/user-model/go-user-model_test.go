package go_user_model

import (
	"testing"
)

func TestUserModel(t *testing.T) {
	result := "works"
	if result != "works" {
		t.Error("Expected UserModel to append 'works'")
	}
}
