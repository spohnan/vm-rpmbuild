class UrlMappings {

	static mappings = {

        // First look for standard Grails URLs
        "/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

        // Path through anything else to the default view
        // as we're doing all the rest of the navigation
        // on the client side
        "/$view?"(view:"/index")

		"500"(view:'/error')
	}
}
