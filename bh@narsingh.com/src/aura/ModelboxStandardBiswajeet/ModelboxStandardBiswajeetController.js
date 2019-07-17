({
    handleModelAction: function(component) {
        var modalBody;
        $A.createComponent("c:ModelboxHeader",{},
                          function(content,status,errorMessage)
                           {
                               console.log('.Status.'+status);
                               if(status==="SUCCESS")
                               {
                                   modalBody=content;
                                   component.find("overlayLib").showCustomModal({
                                       header:"Modal Box",
                                       body:modalBody,
                                       showCloseButton:true,
                                       cssClass:"mymodal",
                                       closeCallback:function()
                                       {
                                           alert('successfully close.');
                                       }
                                   });
                               }
                           });
    },
    handleModelAction1: function(component) {
        var modalBody;
        var modalFooter;
        $A.createComponents([
            ["c:ModelboxHeader",{}],
            ["c:ModelboxFooter",{}]
        ],
                            function(components, status){
                                if (status === "SUCCESS") {
                                    modalBody = components[0];
                                    modalFooter = components[1];
                                    component.find('overlayLib').showCustomModal({
                                        header: "Application Confirmation",
                                        body: modalBody, 
                                        footer: modalFooter,
                                        showCloseButton: true,
                                        cssClass: "my-modal,my-custom-class,my-other-class",
                                        closeCallback: function() {
                                            alert('You closed the alert!');
                                        }
                                    })
                                }
                            }
                           );
    },
    handleModelAction1: function(component) {
        var modalBody;
        var modalFooter;
        $A.createComponents([
            ["c:ModelboxHeader",{}],
            ["c:ModelboxFooter",{}]
        ],
                            function(components, status){
                                if (status === "SUCCESS") {
                                    modalBody = components[0];
                                    modalFooter = components[1];
                                    component.find('overlayLib').showCustomModal({
                                        header: "Application Confirmation",
                                        body: modalBody, 
                                        footer: modalFooter,
                                        showCloseButton: true,
                                        cssClass: "my-modal,my-custom-class,my-other-class",
                                        closeCallback: function() {
                                            alert('You closed the alert!');
                                        }
                                    })
                                }
                            }
                           );
    }
})