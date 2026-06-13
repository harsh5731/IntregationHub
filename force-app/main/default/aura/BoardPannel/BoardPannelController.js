({
    startNewGame : function(component, event, helper) {

        console.log('startNewGame Clicked');
        let cmp = component.find('gameMode');

        console.log('Selected Game Mode: ' + cmp.get("v.value"));

        component.set("v.selectedMode", cmp.get("v.value"));

    },

    reshuffleWords : function(component, event, helper) {

        console.log('reshuffleWords Clicked');

    }
})