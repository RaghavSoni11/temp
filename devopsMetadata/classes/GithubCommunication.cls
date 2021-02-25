public with sharing class GithubCommunication {
    
    public static void getFromGithub(){
        HTTP h = new HTTP();
        HTTPRequest r = new HTTPRequest();
        r.setEndpoint('https://api.github.com/repos/Himanshupate/temp');
        Blob headerValue = Blob.valueOf('Himanshupate' + ':' + '12@github');
        String authorizationHeader = 'Basic' + EncodingUtil.base64Encode(headerValue);
        r.setHeader('Authorization', authorizationHeader);
        //r.setHeader('If-Modified-Since', 'Thu, 05 Jul 2012 15:31:30 GMT');
        r.setHeader('Accept', 'application/json');
        r.setHeader('Content-Type', 'application/json');
        r.setMethod('GET');
        try
        {
            HTTPResponse resp1 = h.send(r);
            System.debug('Response - '+ resp1.getBody()); 
            
        }catch (Exception e)
        {}
    }
    public static void postToGithub(){
        String body = '{as : fd}';
        HTTP h = new HTTP();
        HTTPRequest r = new HTTPRequest();
        //r.setEndpoint('https://api.github.com/Himanshupate');
        r.setEndpoint('https://api.github.com/repos/Himanshupate/temp');
        Blob headerValue = Blob.valueOf('Himanshupate' + ':' + '12@github');
        String authorizationHeader = 'Basic' + EncodingUtil.base64Encode(headerValue);
        r.setHeader('Authorization', authorizationHeader);
        //r.setHeader('If-Modified-Since', 'Thu, 05 Jul 2012 15:31:30 GMT');
        r.setHeader('Accept', 'application/json');
        r.setHeader('Content-Type', 'application/json');
        r.setMethod('POST');
        r.setBody(body);
        try
        {
            HTTPResponse resp1 = h.send(r);
            System.debug('Response - '+ resp1.getBody()); 
            
        }catch (Exception e)
        {}
    }
    
    public static void postToGithub1(){
        String token = 'e3f753658297dccd3853dd0656121238bad6eb79';
        String method = 'POST';
       String body = JSONContactsMethod();
         //String body = 'snbkk smc ms ';
        String organization = 'Himanshupate';
        String repository = 'temp';
        String url = 'https://api.github.com/repos/' + organization + '/' + repository + '/git/blobs';
        //String url = 'https://api.github.com/repos/' + organization + '/' + repository + '/';
        //String url = 'https://api.github.com/repos/' + repository + '/';
        //    if (endpoint.contains('https://')) {
        //         url = endpoint;
        //     } else {
        //         url += endpoint;
        //     }
        
        HttpRequest req = new HttpRequest();
        
        // if (method == 'PATCH') {
        //     String patchParam = '?';
        //     if (url.contains('?')) {
        //         patchParam = '&';
        //     }
        //     patchParam += '_HttpMethod=PATCH';
        //     req.setEndpoint(url+patchParam);
        //     req.setMethod('POST');
        // } else {
        //     req.setEndpoint(url);
        //     req.setMethod(method);
        // }
        
        req.setEndpoint(url);
        req.setMethod(method);
        
        
        if (body != null) {
            //req.setBody( body);
        }
        
        // Blob headerValue = Blob.valueOf(token+':x-oauth-basic');
        // String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        Blob headerValue = Blob.valueOf('Himanshupate' + ':' + '12@github');
        String authorizationHeader = 'token ' + token;
        
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Accept', 'application/vnd.github.v3.full+json');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Content', body);
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        if(res.getStatusCode() == 302){
            System.debug('Response - '+ res.getBody());
        }
        System.debug('Response Code - '+res.getBody());
    }
    
    public static String JSONContactsMethod(){
        JSONGenerator jsonGen = JSON.createGenerator(true);
        jsonGen.writeStartObject();
        jsonGen.writeFieldName('content');
        jsonGen.writeStartObject();        
        jsonGen.writeStringField('message','HimanshuComitted');
        
        jsonGen.writeEndObject();
        
        //jsonGen.writeEndArray();
        jsonGen.writeEndObject();
        String jsonData = jsonGen.getAsString();
        System.debug('Json Data - ' + jsonData);
        return jsonData;
    }
}