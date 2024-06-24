const jwt = require('jsonwebtoken');

const auth =async (req, res ,next)=>{

    try {
        const token=req.header('x-auth-token');
        if(!token){
            res
                .status(401)
                .json({msg:"no auth token,Access denied"});

            const verified=jwt.verify(token,'passwordKey');
            if(!verified) return res.status(401).json({msg:"token verification failed, authorization denied"});

            req.user=verified.id;
            req.token=token;
            next();
        }
    } catch (E) {
        res.status(500).json({error:E.message});
    }
}

module.exports=auth;